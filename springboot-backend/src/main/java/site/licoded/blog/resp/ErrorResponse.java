package site.licoded.blog.resp;

import site.licoded.blog.enums.ResponseEnum;

public class ErrorResponse extends Response{
    public ErrorResponse(ResponseEnum resp){
        this.setSuccess(false);
        this.setCode(resp.getCode());
        this.setMessage(resp.getMsg());
        this.setContent(null);
    }
    public ErrorResponse(String msg){
        this.setSuccess(false);
        this.setCode(ResponseEnum.UNDEFINED_ERROR.getCode());
        this.setMessage(msg);
        this.setContent(null);
    }
}
