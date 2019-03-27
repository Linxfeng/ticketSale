package com.linxf.common.vo;

import lombok.Data;
import lombok.Getter;

/**
 * 页面请求的响应对象
 *
 * @author lintao
 * @date 2019/3/27
 */
@Data
public class ResponseVo<T> {

    /** 响应码 */
    private String code;

    /** 提示信息 */
    private String message;

    /** 状态码 */
    private Integer status;

    /** 数据 */
    private T data;

    @Getter
    public enum ResponseVoEnum {

        SUCCESS("0000", "成功", 200),
        ERROR_FAILED("0001", "服务异常", 500),
        FAILED("0002", "服务逻辑异常", 500),
        TIME_OUT("0004", "登陆超时", 401),
        NO_AUTHORITIES("0005", "没有权限访问", 403),
        NOT_LOGGED_IN("0006", "未登录", 401),
        NO_HANDLER_FOUND("0007", "未匹配URL", 404),
        NO_DATA_FOUND("0008", "查询不到数据", 200),;

        private String code;
        private String message;
        private Integer status;

        ResponseVoEnum(String code, String message, Integer status) {
            this.code = code;
            this.message = message;
            this.status = status;
        }
    }

    public ResponseVo() {
    }

    public ResponseVo(ResponseVoEnum responseVoEnum, String message, T data) {
        this.code = responseVoEnum.getCode();
        this.status = responseVoEnum.getStatus();
        this.data = data;
        if (message != null) {
            this.message = message;
        } else {
            this.message = responseVoEnum.getMessage();
        }
    }

    public static ResponseVo success(String message) {
        return new ResponseVo(ResponseVoEnum.SUCCESS, message, null);
    }

    public static ResponseVo success(Object data) {
        return new ResponseVo(ResponseVoEnum.SUCCESS, null, data);
    }

    public static ResponseVo success(String message, Object data) {
        return new ResponseVo(ResponseVoEnum.SUCCESS, message, data);
    }

    public static ResponseVo failed(String message) {
        return new ResponseVo(ResponseVoEnum.FAILED, message, null);
    }

    public static ResponseVo noDataFailed(String message) {
        return new ResponseVo(ResponseVoEnum.NO_DATA_FOUND, message, null);
    }

}
