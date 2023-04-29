package site.licoded.blog.config;

import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.TypeMismatchException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.NoHandlerFoundException;
import site.licoded.blog.enums.ResponseEnum;
import site.licoded.blog.resp.ErrorResponse;
import site.licoded.blog.resp.Response;

@RestControllerAdvice
    public class ExceptionsHandler {
        /**
         * 自定义异常
         */
        @ExceptionHandler(value = MyException.class)
        Response handlerException(MyException e) {
            return new ErrorResponse(e.getResp());
        }
        /**
         * 空指针异常
         */
        @ExceptionHandler(NullPointerException.class)
        public Response nullPointerExceptionHandler(NullPointerException e) {
            return new ErrorResponse(ResponseEnum.NULL_Pointer);
        }
        /**
         * SQL Syntax 异常
         */
        @ExceptionHandler(BadSqlGrammarException.class)
        public Response SQLSyntax(BadSqlGrammarException e) {
            return new ErrorResponse(e.getCause().toString());
        }
        @ExceptionHandler(DataIntegrityViolationException.class)
        public Response server500(DataIntegrityViolationException e) {
            return new ErrorResponse(e.getCause().toString());
        }
        /**
         * mybatis异常
         */
        @ExceptionHandler(MyBatisSystemException.class)
        public Response mybatisException(MyBatisSystemException e) {
            return new ErrorResponse(e.getCause().toString());
        }
        /**
         * 输入异常
         */
        @ExceptionHandler(HttpMessageNotReadableException.class)
        public Response inputNotReadable(HttpMessageNotReadableException e) {
            return new ErrorResponse(e.getMessage());
        }

        @ExceptionHandler(TypeMismatchException.class)
        public Response numberFormatError(TypeMismatchException e){
            return new ErrorResponse(e.getMessage());
        }

        /**
         * 404未找到
         */
        @ExceptionHandler(NoHandlerFoundException.class)
        public Response notFound404(NoHandlerFoundException e) {
            return new ErrorResponse(ResponseEnum.NOT_FOUND);
        }
        /**
         * 500错误
         */
        @ExceptionHandler(RuntimeException.class)
        public Response server500(RuntimeException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCause());
            System.out.println(e.getClass());
            return new ErrorResponse(ResponseEnum.INTERNAL_SERVER_ERROR);
        }
    }