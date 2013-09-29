
<%@ page import="phonelibv2.Book" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		 <r:require module="jquery"/> 
	</head>
	<body>
		<a href="#show-book" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-book" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div id="bookHeader">
			<div id="bookheadImg"></div>
			<div id="bookattr"></div><br/>
			<div id="bookIntro">
				<div class="title">--内容简介--</div>
			</div>
			<br/>
			<div>书评</div>
			<br/>
			<div id="doubanSummary"></div>
			
<script type="text/javascript" src="/phonelibV2/js/douban_api.js"></script>
<script>
//alert(${bookInstance.isbn13});
DOUBAN.apikey = 
	DOUBAN.getISBNBook({
	    isbn:${bookInstance.isbn13},
	    callback:function(re){
	       eletest=document.getElementById("bookheadImg");
	       eletest.innerHTML='<img src="'+re.images.medium+'"></img>'; 
	       // alert(re.title);
	       //eletest.parentNode.appendChild(re.title);
	       //alert(re.isbn13);
	       eletest=document.getElementById("bookattr");
	       eletest.innerHTML='<h2>'+re.title+'</h2>';
	       var newUl = document.createElement('ul'); 
	       eletest.appendChild(newUl);
	       
	       var newLi = document.createElement('li'); 
	       newLi.innerHTML="作者："+re.author;
	       eletest.lastChild.appendChild(newLi);
	       
	       var newLi1 = document.createElement('li'); 
	       newLi1.innerHTML="出版社："+re.publisher;
	       eletest.lastChild.appendChild(newLi1);

	       var newLi2 = document.createElement('li'); 
	       newLi2.innerHTML="出版时间："+re.pubdate;
	       eletest.lastChild.appendChild(newLi2);

	       var newLi3 = document.createElement('li'); 
	       newLi3.innerHTML="ISBN："+re.isbn13;
	       eletest.lastChild.appendChild(newLi3);

	       eletest1=document.getElementById("bookIntro");
	       var newDiv = document.createElement('div'); 
	       newDiv.innerHTML="    "+re.summary;
	       eletest1.appendChild(newDiv);
	       //alert(eletest1.lastChild.innerHTML);
	    }
	})
</script>
<script>
//alert(${bookInstance.isbn13});
DOUBAN.apikey = 
	DOUBAN.getISBNBookReviews({
	    isbn:${bookInstance.isbn13},
	    callback:function(re){
	       eletest=document.getElementById("bookComments");
	       //eletest.innerHTML=re.
	    }
	})
</script>
<script>
//增加豆瓣评论
var douban = {
		baseUrl:'http://api.douban.com/book/subject/isbn/',
		params:{
			cat:'book',
			'start-index':1,
			'max-results':5,
			alt:'xd',
			apikey:'5240b178dcc68686f6c2146a96539392',
			callback:'douban.appendHTML'
		},
		magicBox:'doubanSummary',
		buildUrl:function(isbnID){
			var ps = this.params,string='';
			for(var i in ps)
				string += i + '='+ ps[i]+ '&amp;';
			
			return this.baseUrl + isbnID + '/reviews' + "?" + string;
		},
		appendRequestScript:function(url){
			var head = document.getElementsByTagName("head")[0];
			var script = document.createElement("script");
			script.src = url;
			script.charset = 'utf-8';
			head.appendChild(script);
		},
		appendHTML:function(json){
			$('#doubanSummary').html(this.render(this.parseJSON(json),json.link[0]['@href']));
			$('#doubanSummary').show();
		},
		parseJSON:function(json){
			var itemCollection=[];
			for(var i in json.entry)
				itemCollection.push(this.parseEntry(json.entry[i]));
			return itemCollection;
		},
		parseEntry:function(entry){
			
			var linkItem = {};
			var authorEntry  = entry["author"]["link"];
			var linkEntry  = entry["link"];
			
			linkItem.title = entry["title"]["$t"];		
			for(var i in linkEntry){
				if(linkEntry[i]['@rel'] == 'icon')
					linkItem.icon = linkEntry[i]['@href'];
				if(linkEntry[i]['@rel'] == 'alternate')
					linkItem.link = linkEntry[i]['@href'];
			}
			linkItem.name = entry["author"]["name"]["$t"];
			for(var i in authorEntry){		
				if(linkEntry[i]['@rel'] == 'alternate')
					linkItem.authorlink = linkEntry[i]['@href'];
			}		
			linkItem.published = entry["published"]["$t"];
			linkItem.summary =  entry["summary"]["$t"];
			return linkItem;
		},
		render:function(itemCollection, link){
			var html='';
			for(var i in itemCollection){
				html+='<div><span class="author">'+ itemCollection[i].name +'</span> '
					+' <span class="date">' + itemCollection[i].published.substr(0,19).replace('T', ' ')  
					+ '</span></div>'
					+'<span class="text">'+ itemCollection[i].summary
					+'<a href="'+itemCollection[i].link+'" target="_blank" class="link">'
					+'(更多)</a></span>'	;
			}
			html = html
			+'<span class="text">'
			+'<a href="'+link+'" target="_blank" class="link">'
			+'查看更多评论</a></span>'
			return html;
		},
		init:function(isbn){
			this.appendRequestScript(this.buildUrl(isbn));
		}
	}
	douban.init(${bookInstance.isbn13})
</script>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${bookInstance?.id}" />
					<g:link class="edit" action="edit" id="${bookInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
