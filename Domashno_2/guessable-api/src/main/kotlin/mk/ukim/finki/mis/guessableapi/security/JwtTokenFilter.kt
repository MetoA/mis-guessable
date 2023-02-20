package mk.ukim.finki.mis.guessableapi.security

import jakarta.servlet.FilterChain
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import mk.ukim.finki.mis.guessableapi.service.UserService
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource
import org.springframework.stereotype.Component
import org.springframework.web.filter.OncePerRequestFilter

@Component
class JwtTokenFilter(val userService: UserService) : OncePerRequestFilter() {

    override fun doFilterInternal(
        request: HttpServletRequest,
        response: HttpServletResponse,
        filterChain: FilterChain
    ) {
        try {
            parseJwt(request)?.let {
                if (isValidJwtToken(it)) {
                    val username = getUsernameFromJwtToken(it)
                    val userDetails = userService.loadUserByUsername(username)
                    val authentication = UsernamePasswordAuthenticationToken(
                        userDetails,
                        null,
                        userDetails.authorities
                    )
                    authentication.details = WebAuthenticationDetailsSource().buildDetails(request)
                    SecurityContextHolder.getContext().authentication = authentication
                }
            }
        } catch (_: Exception) {

        }

        filterChain.doFilter(request, response)
    }

    private fun parseJwt(request: HttpServletRequest): String? =
        request.getHeader("Authorization").let {
            if (!it.isNullOrEmpty() && it.startsWith("Bearer ")) {
                return it.substring(7)
            } else {
                null
            }
        }
}
