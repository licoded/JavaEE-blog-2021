package site.licoded.blog.config;

import lombok.AllArgsConstructor;
import lombok.Data;
import site.licoded.blog.enums.ResponseEnum;

@Data
@AllArgsConstructor
public class MyException extends RuntimeException{
    private ResponseEnum resp;
}
