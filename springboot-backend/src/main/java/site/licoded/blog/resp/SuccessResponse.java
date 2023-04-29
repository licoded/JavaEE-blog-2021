package site.licoded.blog.resp;

import site.licoded.blog.enums.ResponseEnum;

public class SuccessResponse extends Response{
    public SuccessResponse(){
        this.setSuccess(true);
        this.setCode(ResponseEnum.SUCCESS.getCode());
        this.setMessage(ResponseEnum.SUCCESS.getMsg());
        this.setContent(null);
    }
    public SuccessResponse(Object obj){
        this.setSuccess(true);
        this.setCode(ResponseEnum.SUCCESS.getCode());
        this.setMessage(ResponseEnum.SUCCESS.getMsg());
        this.setContent(obj);
    }
    public SuccessResponse(Object obj, String msg){
        this.setSuccess(true);
        this.setCode(ResponseEnum.SUCCESS.getCode());
        this.setMessage(msg);
        this.setContent(obj);
    }
}
