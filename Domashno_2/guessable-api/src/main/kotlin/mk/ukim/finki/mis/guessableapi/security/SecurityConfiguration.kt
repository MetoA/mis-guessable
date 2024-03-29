package mk.ukim.finki.mis.guessableapi.security

import mk.ukim.finki.mis.guessableapi.service.UserService
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.AuthenticationProvider
import org.springframework.security.authentication.dao.DaoAuthenticationProvider
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.security.web.SecurityFilterChain
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter

/**
 * Configuration that handles security and authentication
 *
 * @param[userService] [UserService] for communication with the repository for users
 * @param[jwtTokenFilter] a filter that is being processed for every request
 * */
@Configuration
@EnableWebSecurity
class SecurityConfiguration(
    val userService: UserService,
    val jwtTokenFilter: JwtTokenFilter,
) {

    /**
     * A filter chain that processes every request
     *
     * @param[http] [HttpSecurity] to configure every http request
     * @return[SecurityFilterChain]
     * */
    @Bean
    fun filterChain(http: HttpSecurity): SecurityFilterChain =
        http
            .cors().and().csrf().disable()
            .authorizeHttpRequests {
                it.requestMatchers("/api/auth/**", "/api/location/*/image")
                    .permitAll().anyRequest().authenticated()
            }
            .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()
            .authenticationProvider(authenticationProvider())
            .addFilterBefore(jwtTokenFilter, UsernamePasswordAuthenticationFilter::class.java)
            .build()

    /**
     * A password encoder [Bean]
     * @return[BCryptPasswordEncoder]
     * */
    @Bean
    fun passwordEncoder(): BCryptPasswordEncoder = BCryptPasswordEncoder()

    /**
     * An authentication provider [Bean]
     * @return[AuthenticationProvider]
     * */
    @Bean
    fun authenticationProvider(): AuthenticationProvider = DaoAuthenticationProvider().also {
        it.setUserDetailsService(userService)
        it.setPasswordEncoder(passwordEncoder())
    }

    /**
     * An authentication manager [Bean]
     * @return[AuthenticationManager]
     * */
    @Bean
    fun authenticationManager(authenticationConfiguration: AuthenticationConfiguration): AuthenticationManager =
        authenticationConfiguration.authenticationManager
}
