package com.linxf.apigateway.filter;

import com.linxf.common.utils.RedisCacheUtil;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import com.netflix.zuul.exception.ZuulException;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;

import static org.springframework.cloud.netflix.zuul.filters.support.FilterConstants.PRE_TYPE;

/**
 * 鉴权
 *
 * @author lintao
 * @date 2019/4/23
 */
public class AuthenticationFilter extends ZuulFilter {

    @Autowired
    private RedisCacheUtil redisCacheUtil;

    @Override
    public String filterType() {
        return PRE_TYPE; //过滤器类型：pre过滤器
    }

    @Override
    public int filterOrder() {
        return 0;
    }

    @Override
    public boolean shouldFilter() {
        return true;
    }

    /**
     * 鉴权
     */
    @Override
    public Object run() throws ZuulException {

        RequestContext context = RequestContext.getCurrentContext();
        HttpServletRequest request = context.getRequest();

        // 获取请求的参数
        String u_token = request.getHeader("u_token");
        String uid = request.getHeader("uid");
        String token = "";

        if (StringUtils.isNotBlank(uid))
            token = redisCacheUtil.getValue(uid);

        if (StringUtils.isNotBlank(u_token) && StringUtils.isNotBlank(uid)) {
            if (StringUtils.equals(token, u_token)) {
                context.setSendZuulResponse(true); //对请求进行路由
                context.setResponseStatusCode(200);
                context.set("isSuccess", true);
            }
        } else {
            context.setSendZuulResponse(false); //不路由
            context.setResponseStatusCode(400);
            context.setResponseBody("Access Denied! No Login");
            context.set("isSuccess", false);
        }
        return null;
    }
}
