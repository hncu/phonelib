package phonelibv2

import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.SecurityUtils

class SignupController {
    def shiroSecurityService

    def index() {
        ShiroUser user = new ShiroUser()
        [user: ShiroUser]
    }

    def register() {
        // Check to see if the username already exists
        def user = ShiroUser.findByUsername(params.username)
        if (user) {
            flash.message = "User already exists with the username '${params.username}'"
            redirect(action:'index')
        } else { // User doesn't exist with username. Let's create one
            // Make sure the passwords match
            if (params.password != params.password2) {
                flash.message = "Passwords do not match"
                redirect(action:'index')
            } else { // Passwords match. Let's attempt to save the user
                // Create user
                user = new ShiroUser(username: params.username,passwordHash: shiroSecurityService.encodePassword(params.password))

                if (user.save()) {
                    // Add USER role to new user
                    user.addToRoles(ShiroRole.findByName('ROLE_USER'))
                    // Login user
                    def authToken = new UsernamePasswordToken(user.username, params.password)
                    SecurityUtils.subject.login(authToken)

                    redirect(controller: 'book', action: 'list')
                }else {}
            }
        }
    }
}