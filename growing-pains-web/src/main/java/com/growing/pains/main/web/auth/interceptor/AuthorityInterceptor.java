package com.growing.pains.main.web.auth.interceptor;

import com.google.common.collect.Lists;
import com.growing.pains.main.web.auth.context.PermissionContext;
import com.growing.pains.main.web.auth.context.PermissionContextKey;
import com.growing.pains.main.web.auth.context.SessionContext;
import com.growing.pains.main.web.auth.flow.*;
import com.growing.pains.model.entity.system.UserEntity;
import com.growing.pains.service.system.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @author: miaoxing
 * DATE:    16/7/5
 */
@Component
public class AuthorityInterceptor implements HandlerInterceptor {

    final private Logger logger = LoggerFactory.getLogger(AuthorityInterceptor.class);

    private List<HttpAuthFlow> authChain;

    @Resource
    private UserService userService;

    /**
     * 初始化默认的验证流程
     */
    @PostConstruct
    public void initAuth() {
        authChain = Lists.newArrayList();
        authChain.add(0, new InitAuthFlow(userService));
        authChain.add(1, new PublicAuthFlow());
        authChain.add(2, new CookieExpireAuthFlow());
        authChain.add(3, new UriAuthFlow());

        logger.info("PERMISSIONS-AUTHORITY-INTERCEPTOR: DEFAULT auth flow initialized. in order : ");
        for (int i = 0; i < authChain.size(); i++) {
            logger.info("{} : {}", i, authChain.get(i));
        }
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handlerObject)
            throws Exception {
        if (!(handlerObject instanceof HandlerMethod)) {
            return true;
        }

        AuthResult authResult = new AuthResult();
        if (!CollectionUtils.isEmpty(authChain)) {
            for (HttpAuthFlow authFlow : authChain) {
                if (!authFlow.support(authResult)) {
                    continue;
                }
                authResult = authFlow.auth(authResult, request, response, (HandlerMethod) handlerObject);
            }
        }

        if (authResult.getSuccess() == null || authResult.getSuccess()) {
            // 初始化Session
            initSessionInContext(authResult.getUser());
            return true;
        }

        if (request.getRequestURI().contains(".json")) {
            try {
                response.getWriter().write("您已失去登录状态, 请重新登录");
                response.getWriter().flush();
                response.getWriter().close();
                return false;
            } catch (IOException e) {
                logger.error("返回登录超时信息时错误: {}", e.getMessage(), e);
            }
        }

        response.sendRedirect("/system/authError.htm");
        return false;
    }

    /**
     * 初始化session信息
     *
     * @param user
     */
    private void initSessionInContext(final UserEntity user) {
        if (user == null) {
            return;
        }
        // 初始化Context
        PermissionContext.putCurrent(PermissionContextKey.CURRENT_USER, user);

        // 后续可根据业务增加其他权限Context
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            modelAndView.addObject("username", SessionContext.getCurrentUser().getUserName());
            if (SessionContext.getCurrentUser().getId() > 0) {
                modelAndView.addObject("isLogin", true);
            } else {
                modelAndView.addObject("isLogin", false);
            }
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
    }
}
