package phonelibv2

import org.springframework.dao.DataIntegrityViolationException
import groovy.json.*
import org.codehaus.groovy.grails.web.json.JSONObject

class LibbookController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 2, 100)
        [libbookInstanceList: Libbook.list(params), libbookInstanceTotal: Libbook.count()]
    }

    def create() {
        [libbookInstance: new Libbook(params)]
    }

    def save() {
        def libbookInstance = new Libbook(params)
        if (!libbookInstance.save(flush: true)) {
            render(view: "create", model: [libbookInstance: libbookInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'libbook.label', default: 'Libbook'), libbookInstance.id])
        redirect(action: "show", id: libbookInstance.id)
    }

    def show() {
        def libbookInstance = Libbook.get(params.id)
        if (!libbookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'libbook.label', default: 'Libbook'), params.id])
            redirect(action: "list")
            return
        }

        [libbookInstance: libbookInstance]
    }

    def edit() {
        def libbookInstance = Libbook.get(params.id)
        if (!libbookInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'libbook.label', default: 'Libbook'), params.id])
            redirect(action: "list")
            return
        }

        [libbookInstance: libbookInstance]
    }

    def update() {
        def libbookInstance = Libbook.get(params.id)
        if (!libbookInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'libbook.label', default: 'Libbook'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (libbookInstance.version > version) {
                libbookInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'libbook.label', default: 'Libbook')] as Object[],
                          "Another user has updated this Libbook while you were editing")
                render(view: "edit", model: [libbookInstance: libbookInstance])
                return
            }
        }

        libbookInstance.properties = params

        if (!libbookInstance.save(flush: true)) {
            render(view: "edit", model: [libbookInstance: libbookInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'libbook.label', default: 'Libbook'), libbookInstance.id])
        redirect(action: "show", id: libbookInstance.id)
    }

    def delete() {
        def libbookInstance = Libbook.get(params.id)
        if (!libbookInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'libbook.label', default: 'Libbook'), params.id])
            redirect(action: "list")
            return
        }

        try {
            libbookInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'libbook.label', default: 'Libbook'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'libbook.label', default: 'Libbook'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
	
	def search(){
		
	}	
	
	def updateBook(){
		
		for(int i = 0;i<=200;i++){
			params.offset = 81997 +i*1000
		params.max = Math.min(params.max ? params.int('max') : 1000, 1000)
		Libbook.list(params).each {
			JSONObject json= getbooksummy("${it.isbn13}")
			if(json){
				String author = json.author
				String pubdate = json.pubdate
				String imageUrl = json.images.medium
				String title = json.title
				String publisher = json.publisher
				String summary = json.summary
				String temp = json.tags
				temp = temp.replaceAll("\\[", "{")
				temp = temp.replaceAll("\\]","}" )
				
				temp = temp.replaceFirst("\\{", "[")
				temp = temp.replaceAll("\\}}", "}]")
				
				String tags = "{\"tags\":"+temp+"}"
				print(temp)
			//	print(summary)
				params.author = author
				params.pubdate = pubdate
				params.imageUrl = imageUrl
				params.title = title
				params.publisher = publisher
				params.summary = summary
				params.tags = tags
			//	print(params)
				def libbookInstance = Libbook.get(it.id)
				print(libbookInstance)
				libbookInstance.properties = params
				if (!libbookInstance.save(flush: true)) {
					render(view: "edit", model: [bookInstance: libbookInstance])
					return
				}
			}
		}
		}
	}
	
	def getbooksummy(String isbn){
		StringBuffer html = new StringBuffer();
		String result = null;
		try {
			URL url = new URL("https://api.douban.com/v2/book/isbn/"+isbn+"?alt=xd&callback=?");
			URLConnection conn = url.openConnection();
			conn.setRequestProperty(
					"User-Agent",
					"Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; GTB5; .NET CLR 2.0.50727; CIBA)");
			BufferedInputStream ins = new BufferedInputStream(conn.getInputStream());
			try {
				String inputLine;
				byte[] buf = new byte[4096];
				int bytesRead = 0;
				while (bytesRead >= 0) {
					inputLine = new String(buf, 0, bytesRead, "utf-8");
					html.append(inputLine);
					bytesRead = ins.read(buf);
					inputLine = null;
				}
				buf = null;
			} finally {
				//ins.close();
				conn = null;
				url = null;
			}
			result = new String(html.toString().trim().getBytes("utf-8"),
					"utf-8").toLowerCase();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		html = null;
		JSONObject json= new JSONObject(result)
		return json;
	}
}
