package com.assist.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class PermissionInterceptor implements HandlerInterceptor {

//	private Logger logger = LoggerFactory.getLogger(PermissionInterceptor.class);
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws IOException {

		logger.info("[### preHandle]" + request.getRequestURI());

		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");

		String uri = request.getRequestURI();

		if (userId != null && uri.startsWith("/user")) {
			response.sendRedirect("/contents/home_view");

			return false;
		} else if (userId == null && uri.startsWith("/contents")) {
			response.sendRedirect("/user/sign_in_view");

			return false;
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) {

		logger.warn("[### postHandle]" + request.getRequestURI());
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception exception) {

		logger.error("[### afterCompletion]" + request.getRequestURI());
	}
}
