package mk.ukim.finki.mis.guessableapi.api

import mk.ukim.finki.mis.guessableapi.requests.AuthRequest
import mk.ukim.finki.mis.guessableapi.responses.JwtTokenResponse
import mk.ukim.finki.mis.guessableapi.security.generateJwtToken
import mk.ukim.finki.mis.guessableapi.service.AuthService
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/auth")
class AuthController(val service: AuthService) {

    @PostMapping("/login")
    fun login(@RequestBody request: AuthRequest) = with(request) {
        val authentication = service.login(username, password)
        JwtTokenResponse(generateJwtToken(authentication), authentication.name)
    }

    @PostMapping("/register")
    fun register(@RequestBody request: AuthRequest) = with(request) {
        service.register(username, password)
    }
}
