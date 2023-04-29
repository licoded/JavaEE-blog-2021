package site.licoded.blog.service;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import org.springframework.stereotype.Service;
import site.licoded.blog.entity.User;

@Service("TokenService")
public class TokenService {
    public static String getToken(User user){
        String token = "";
        token= JWT.create().withAudience(user.getId().toString())
                .sign(Algorithm.HMAC256(user.getPassword()));
        return token;
    }
}
