package com.linxf.apigateway.filter;

import com.google.common.util.concurrent.RateLimiter;
import com.linxf.apigateway.exception.RateLimitException;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.exception.ZuulException;

import static org.springframework.cloud.netflix.zuul.filters.support.FilterConstants.PRE_TYPE;
import static org.springframework.cloud.netflix.zuul.filters.support.FilterConstants.SERVLET_DETECTION_FILTER_ORDER;

/**
 * 限流
 *
 * @author lintao
 * @date 2019/3/26
 */
public class RateLimitFilter extends ZuulFilter {

    //令牌桶机制-每秒产生100个
    private static final RateLimiter RATE_LIMITER = RateLimiter.create(100);

    @Override
    public String filterType() {
        return PRE_TYPE; //过滤器类型：pre过滤器
    }

    @Override
    public int filterOrder() { //过滤位置：最先
        return SERVLET_DETECTION_FILTER_ORDER - 1;
    }

    @Override
    public boolean shouldFilter() {
        return true;
    }

    @Override
    public Object run() throws ZuulException {

        if (!RATE_LIMITER.tryAcquire()) {
            throw new RateLimitException();
        } //如果没拿到令牌，则抛出异常

        return null;
    }

}
