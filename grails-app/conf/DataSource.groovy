dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "zyk"
    password = "18273716526"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:mysql://localhost:3306/phonelibV2test"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost:3306/phonelibV2test"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost:3306/phonelibV2test"
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }
    }
}


/*production {
	def envVar = System.env.VCAP_SERVICES
	def credentials = envVar?grails.converters.JSON.parse(envVar)["mysql-5.1"][0]["credentials"]:null
 
	dataSource {
	   pooled = true
	   dbCreate = "update"
	   driverClassName = "com.mysql.jdbc.Driver"
	   url =  credentials?"jdbc:mysql://${credentials.hostname}:${credentials.port}/${credentials.name}?useUnicode=yes&characterEncoding=UTF-8":""
	   username = credentials?credentials.username:""
	   password = credentails?credentials.password:""
	}
 }*/