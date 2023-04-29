package site.licoded.blog.enums;

import lombok.Getter;

public enum ResponseEnum {

    SUCCESS(200, "ok"),
    NOT_FOUND(404, "未找到"),
    USER_NOT_FOUND(404, "用户名或密码错误"),
    ACCOUNT_OCCUPIED(404, "该OJ账号已绑定"),
    ACCOUNT_NOT_FOUND(404, "未绑定该OJ账号"),
    RECORDS_EXIST(3001, "记录已存在"),//重复添加记录（用户）
    REQUIRED_TOKEN(2001, "缺少token"),
    ILLEGAL_TOKEN(2002, "token不合法，token解析或验证失败"),
    TOKEN_USER_NOT_FOUND(2003, "token对应的用户不存在"),
    INTERNAL_SERVER_ERROR(500, "服务器内部错误"),
    NULL_Pointer(2000, "空指针异常"),
    UNDEFINED_ERROR(1000, "未定义的错误");

    @Getter private Integer code;
    @Getter private String msg;

    ResponseEnum(Integer code, String msg){
        this.code = code;
        this.msg = msg;
    }
}
