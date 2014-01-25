package phonelibv2
import groovy.json.JsonSlurper
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.web.util.SavedRequest
import org.apache.shiro.web.util.WebUtils
import org.apache.shiro.grails.ConfigUtils

class AuthController {
    def shiroSecurityManager

    def index = { redirect(action: "login", params: params) }

    def login = {
		def targetUri = params.targetUri
		if(targetUri!=null){
			flash.message = message(code: "login.unlogin")
		}
        return [ username: params.username, rememberMe: (params.rememberMe != null), targetUri: params.targetUri ]
    }

    def signIn = {
        def authToken = new UsernamePasswordToken(params.username, params.password as String)
		println(params)
        // Support for "remember me"
        if (params.rememberMe) {
            authToken.rememberMe = true
        }
        
        // If a controller redirected to this page, redirect back
        // to it. Otherwise redirect to the root URI.
        def targetUri = params.targetUri ?: "/"
		
        // Handle requests saved by Shiro filters.
        def savedRequest = WebUtils.getSavedRequest(request)
        if (savedRequest) {
            targetUri = savedRequest.requestURI - request.contextPath
            if (savedRequest.queryString) targetUri = targetUri + '?' + savedRequest.queryString
        }
        
        try{
            // Perform the actual login. An AuthenticationException
            // will be thrown if the username is unrecognised or the
            // password is incorrect.
            SecurityUtils.subject.login(authToken)
            log.info "Redirecting to '${targetUri}'."
            redirect(url:"/book/list")
        }
        catch (AuthenticationException ex){
            // Authentication failed, so display the appropriate message
            // on the login page.
            log.info "Authentication failure for user '${params.username}'."
            flash.message = message(code: "login.failed")

            // Keep the username and "remember me" setting so that the
            // user doesn't have to enter them again.
            def m = [ username: params.username ]
            if (params.rememberMe) {
                m["rememberMe"] = true
            }

            // Remember the target URI too.
            if (params.targetUri) {
                m["targetUri"] = params.targetUri
            }
				
            // Now redirect back to the login page.
            redirect(action: "login", params: m)
        }
    }

    def signOut = {
        // Log the user out of the application.
        def principal = SecurityUtils.subject?.principal
        SecurityUtils.subject?.logout()
        // For now, redirect back to the home page.
        if (ConfigUtils.getCasEnable() && ConfigUtils.isFromCas(principal)) {
            redirect(uri:ConfigUtils.getLogoutUrl())
        }else {
            redirect(uri: "/")
        }
        ConfigUtils.removePrincipal(principal)
    }

    def unauthorized = {
        render "You do not have permission to access this page."
    }
	
	def phoneSignIn = {
		def authToken = new UsernamePasswordToken(params.username, params.password as String)
		print(params)
		// Support for "remember me"
		if (params.rememberMe) {
			authToken.rememberMe = true
		}
		
		// If a controller redirected to this page, redirect back
		// to it. Otherwise redirect to the root URI.
		def targetUri = params.targetUri ?: "/"
		
		// Handle requests saved by Shiro filters.
		def savedRequest = WebUtils.getSavedRequest(request)
		if (savedRequest) {
			targetUri = savedRequest.requestURI - request.contextPath
			if (savedRequest.queryString) targetUri = targetUri + '?' + savedRequest.queryString
		}
		print(""+session.isNew()+session.id)
		if(session.isNew()){
			try{
				// Perform the actual login. An AuthenticationException
				// will be thrown if the username is unrecognised or the
				// password is incorrect.
				SecurityUtils.subject.login(authToken)
				//log.info "Redirecting to '${targetUri}'."
				//render(contentType:"text/json"){ rend(signIn:"Y",ownInstance:ownInstance.isbn13)}
				
				render(contentType:"text/json"){ rend(signIn:"Y")}
			}
			catch (AuthenticationException ex){
				// Authentication failed, so display the appropriate message
				// on the login page.
				log.info "Authentication failure for user '${params.username}'."
				flash.message = message(code: "login.failed")
				
				// Keep the username and "remember me" setting so that the
				// user doesn't have to enter them again.
				def m = [ username: params.username ]
				if (params.rememberMe) {
					m["rememberMe"] = true
				}
	
				// Remember the target URI too.
				if (params.targetUri) {
					m["targetUri"] = params.targetUri
				}
					
				// Now redirect back to the login page.
				render(contentType:"text/json"){ rend(signIn:"N")}
			}
		}else{
			render(contentType:"text/json"){ rend(signIn:"Y")}
		}
	}
	
	
}