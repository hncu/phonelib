package phonelibv2

import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.dao.DataIntegrityViolationException
import org.apache.shiro.SecurityUtils

class CategoryController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def bgindex() {
        redirect(action: "bglist", params: params)
    }

    def bglist() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [categoryInstanceList: Category.list(params), categoryInstanceTotal: Category.count()]
    }

    def bgcreate() {
        [categoryInstance: new Category(params)]
    }

    def bgsave() {
        def categoryInstance = new Category(params)
        if (!categoryInstance.save(flush: true)) {
            render(view: "bgcreate", model: [categoryInstance: categoryInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.id])
        redirect(action: "bgshow", id: categoryInstance.id)
    }

    def bgshow() {
        def categoryInstance = Category.get(params.id)
        if (!categoryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
            redirect(action: "bglist")
            return
        }

        [categoryInstance: categoryInstance]
    }

    def bgedit() {
        def categoryInstance = Category.get(params.id)
        if (!categoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
            redirect(action: "bglist")
            return
        }

        [categoryInstance: categoryInstance]
    }

    def bgupdate() {
        def categoryInstance = Category.get(params.id)
        if (!categoryInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
            redirect(action: "bglist")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (categoryInstance.version > version) {
                categoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'category.label', default: 'Category')] as Object[],
                          "Another user has updated this Category while you were editing")
                render(view: "bgedit", model: [categoryInstance: categoryInstance])
                return
            }
        }

        categoryInstance.properties = params

        if (!categoryInstance.save(flush: true)) {
            render(view: "bgedit", model: [categoryInstance: categoryInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.id])
        redirect(action: "bgshow", id: categoryInstance.id)
    }

    def bgdelete() {
        def categoryInstance = Category.get(params.id)
        if (!categoryInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
            redirect(action: "bglist")
            return
        }

        try {
            categoryInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'category.label', default: 'Category'), params.id])
            redirect(action: "bglist")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'category.label', default: 'Category'), params.id])
            redirect(action: "bgshow", id: params.id)
        }
    }
	
	
		def index() {
			redirect(action: "list", params: params)
		}
	
		def list() {
			params.max = Math.min(params.max ? params.int('max') : 25, 100)
			[categoryInstanceList: Category.list(params), categoryInstanceTotal: Category.count()]
		}
	
		def create() {
			[categoryInstance: new Category(params)]
		}
	
		def save() {
			def categoryInstance = new Category(params)
			if (!categoryInstance.save(flush: true)) {
				render(view: "create", model: [categoryInstance: categoryInstance])
				return
			}
	
			flash.message = message(code: 'default.created.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.id])
			redirect(action: "show", id: categoryInstance.id)
		}
	
		def show() {
			def categoryInstance = Category.get(params.id)
			if (!categoryInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
				redirect(action: "list")
				return
			}
	
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			
			redirect(uri:"/book/list",  categoryInstanceList: Category.list(params),bookInstanceTotal: Book.count(),bookInstanceList:categoryInstance.books)
		}
	
		def edit() {
			def categoryInstance = Category.get(params.id)
			if (!categoryInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
				redirect(action: "list")
				return
			}
	
			[categoryInstance: categoryInstance]
		}
	
		def update() {
			def categoryInstance = Category.get(params.id)
			if (!categoryInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
				redirect(action: "list")
				return
			}
	
			if (params.version) {
				def version = params.version.toLong()
				if (categoryInstance.version > version) {
					categoryInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
							  [message(code: 'category.label', default: 'Category')] as Object[],
							  "Another user has updated this Category while you were editing")
					render(view: "edit", model: [categoryInstance: categoryInstance])
					return
				}
			}
	
			categoryInstance.properties = params
	
			if (!categoryInstance.save(flush: true)) {
				render(view: "edit", model: [categoryInstance: categoryInstance])
				return
			}
	
			flash.message = message(code: 'default.updated.message', args: [message(code: 'category.label', default: 'Category'), categoryInstance.id])
			redirect(action: "show", id: categoryInstance.id)
		}
	
		def delete() {
			def categoryInstance = Category.get(params.id)
			if (!categoryInstance) {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
				redirect(action: "list")
				return
			}
	
			try {
				categoryInstance.delete(flush: true)
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'category.label', default: 'Category'), params.id])
				redirect(action: "list")
			}
			catch (DataIntegrityViolationException e) {
				flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'category.label', default: 'Category'), params.id])
				redirect(action: "show", id: params.id)
			}
		}
		
		def phoneOwnCategoryList(){
			print(session.id)
			print(params)
			def principal = SecurityUtils.subject?.principal
			print(principal)
			def user = ShiroUser.findByUsername(principal)
			//print(session.+"************************"+user)
			
			def bookInstance = user.own.book
			List categoryList = bookInstance.category
			categoryList.unique()
		//	def resquestCname=["categroy"]
			def count = categoryList.size()
			def resquestArray = []
			JSONObject requestJsonObject = new JSONObject()
			categoryList.each{
				params.max = Math.min(params.max ? params.int('max') : 5, 100)
				def c = Book.createCriteria()
				String cname = it.cname
				def searchByCategory = {
					category{
						eq('cname',cname)
					}
				}
				def books = c.list(params,searchByCategory)
				int bookCount = books.totalCount
				String bookNames = ""
				books.each {
					bookNames +=it.title+","
				}
				resquestArray.add('id':it.id,'cname':"${it.cname}",'book':bookNames ,bookCount:bookCount)
			}
			requestJsonObject.put('categoryCount', categoryList.size())
			requestJsonObject.putOpt('category', resquestArray)
			
			/*categoryList.each {
				def resquestBook=["book"]
				params.max = Math.min(params.max ? params.int('max') : 5, 100)
				def c = Book.createCriteria()
				String cname = it.cname
				def searchByCategory = {
					category{
						eq('cname',cname)
					}
				}
				def books = c.list(params,searchByCategory)
				def bookCount = books.totalCount
				books.each {
					resquestBook.add('title':"${it.title}")
				}
				resquestCname.add('id':"${it.id}",'cname':"${it.cname}",'book':"${resquestBook}" ,bookCount:"${bookCount}")
				
			}
			print(resquestCname)*/
			//categoryInstance.remove("books")
			//categoryJson.remove(categoryJson.class)
		//	JsonBuilder category = categoryInstance
		//	print (category.toString())
		//	category.remove('class')
		//	print(category)
			render(contentType:"text/json"){
				requestJsonObject
			}
			
			
		}
	}
	