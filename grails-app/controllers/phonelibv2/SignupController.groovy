package phonelibv2


import java.awt.GraphicsCallback.PrintAllCallback;
import java.awt.Rectangle
import java.awt.image.BufferedImage
import javax.imageio.ImageIO
import javax.imageio.ImageReadParam
import javax.imageio.ImageReader
import javax.imageio.stream.ImageInputStream
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.UsernamePasswordToken
import sun.misc.BASE64Decoder

class SignupController {
	def shiroSecurityService
	
	def mailService
    def index() {
//        ShiroUser user = new ShiroUser()
//        [user: ShiroUser]
		redirect(action: 'create')
    }

    def register() {
		println params.username;
		def user=ShiroUser.findByUsername(params.username)
        if (user) {
            flash.message = " '${params.username}'，该用户名已经被注册"
            redirect(action:'create')
        } else { // User doesn't exist with username. Let's create one
            // Make sure the passwords match
		println params.passwordHash.length()
		if(params.passwordHash.length()<6){
			flash.message = "密码长度不能少于6位"
			redirect(action:'create')
			}
            if (params.passwordHash != params.password2) {
                flash.message = "两次输入的密码不一致"
                redirect(action:'create')
            } else { // Passwords match. Let's attempt to save the user
                // Create user
//                user = new ShiroUser(username: params.username,passwordHash: shiroSecurityService.encodePassword(params.passwordHash),email:params.email)
			     user = new ShiroUser();
				user.username = params.username
				user.passwordHash = shiroSecurityService.encodePassword(params.passwordHash)
				user.email = params.email
                if (user.save(flush:true)) {
                    // Add USER role to new user
                    user.addToRoles(ShiroRole.findByName('ROLE_USER'))
                    // Login user
                    def authToken = new UsernamePasswordToken(user.username, params.passwordHash)
					mailService.sendMail {
						//to "${params.email}"
						to '2456132330@qq.com'
						from 'xieluhong09 <xieluhong09@126.com>'
						subject "您已完成注册"
						body '感谢您的使用'
					}
					
			
					
                    SecurityUtils.subject.login(authToken)
					
                    redirect(controller: 'book', action: 'list')
                }else {
				render(view: "create", model: [shiroUserInstance: user])
				return
				}
            }
        }
    }
	def save() {
		def shiroUserInstance = new ShiroUser(params)
		if (!shiroUserInstance.save(flush: true)) {
			render(view: "create", model: [shiroUserInstance: shiroUserInstance])
			return
		}
		
		flash.message = message(code: 'default.created.message', args: [message(code: 'shiroUser.label', default: 'ShiroUser'), shiroUserInstance.id])
		redirect(action: "show", id: shiroUserInstance.id)
	}
	def create() {
		[shiroUserInstance: new ShiroUser(params)]
	}

	def accout(){
//		print params.id
		def principal = SecurityUtils.subject?.principal
		def userInstance=ShiroUser.findByUsername(principal)
//		println userInstance
//		println userInstance.nickname
		
		if(params.id == null || "grzl"){
			render(view: "accout/1",model:[userInstance:userInstance]);
			return ;
		}

		if(params.id == "upload"||params.id.equals("upload")){
			redirect(action:"upload")
			return ;
		}
		int i = Integer.parseInt(params.id);
		if(i == null){
			i = 1;
		}
		switch(i){
			case 1:  render(view: "accout/1",model:[]);  break
			case 2:  render(view: "2"); break
			case 3:  render(view: "accout/3"); break
			case 4:  render(view: "accout/4"); break
			case 5:  render(view: "accout/5"); break
			default:render(view: "accout/1");
		}
	}	
	def tx(){
		render(view: "2");
	}
	def touxiang(){
		
				String webRootUrl = servletContext.getRealPath("/") //D:\workspace-ggts\phonelibV2\web-app\
				String _savePath = webRootUrl + "images\\touxiang";
				File touFile = new File(webRootUrl,"images\\touxiang\\");
					String savePicName = new Date().getTime();//已时间取名是唯一的
					
					//为避免在一个文件夹下面保存超过1000个文件，影响文件访问性能，程序应该把上传文件打散后存储。
					int hashcode = savePicName.hashCode();  //121221
					int dir1 = hashcode&15;
					int dir2 = (hashcode>>4)&0xf;
					String savepath = _savePath + File.separator + dir1 + File.separator + dir2;
					File saveFile = new File(savepath);
								if(!saveFile.exists()){
									saveFile.mkdirs();
								}
//		println "savepath=${savepath}" //savepath=D:\workspace-ggts\phonelibV2\web-app\images\touxiang\13\5
		
		String file_src = savepath + File.separator + savePicName + "_src.jpg";    //ä¿å­åå¾
		String filename162 = savepath + File.separator +savePicName + "_162.jpg";  //ä¿å­162
		String filename48 = savepath + File.separator +savePicName + "_48.jpg";  //ä¿å­48
		String filename20 = savepath + File.separator +savePicName + "_20.jpg";  //ä¿å­20
		
//	println "file_src=${file_src}" // file_src=D:\workspace-ggts\phonelibV2\web-app\images\touxiang\2\6\1385299948260_src.jpg
	
		String pic=params.pic
		String pic1=params.pic1
		String pic2=params.pic2
		String pic3=params.pic3
		
		if(!pic.equals("")&&pic!=null){
			File file = new File(file_src);
			if(!saveFile.exists()){
				saveFile.mkdirs();
			}
			FileOutputStream fout = null;
			fout = new FileOutputStream(file);
			fout.write(new BASE64Decoder().decodeBuffer(pic));
			fout.close();
		}
		
		File file1 = new File(filename162);///D:\workspace_10\.metadata\.me_tcat\webapps\touxiang\touxiang\1385277041680_162.jpg
		FileOutputStream fout1 = new FileOutputStream(file1);
		fout1.write(new BASE64Decoder().decodeBuffer(pic1));
		fout1.close();
		
		File file2 = new File(filename48);
		FileOutputStream fout2 = null;
		fout2 = new FileOutputStream(file2);
		fout2.write(new BASE64Decoder().decodeBuffer(pic2));
		fout2.close();
		
		File file3 = new File(filename20);
		FileOutputStream fout3 = null;
		fout3 = new FileOutputStream(file3);
		fout3.write(new BASE64Decoder().decodeBuffer(pic3));
		fout3.close();
		
			String picUrl = savepath+savePicName;
		
		def principal = SecurityUtils.subject?.principal
		def userInstance=ShiroUser.findByUsername(principal)
		println userInstance.username;
		if(userInstance){
		println "filename162="+filename162;
		userInstance.btouxiang = filename162
		println "userInstance.btouxiang="+userInstance.btouxiang;
		
		userInstance.mtouxiang = filename48
		userInstance.stouxiang = filename20
		
		}
		userInstance.save(flash:true);
		render("{\"status\":1,\"picUrl\":\""+picUrl+"\"}")//返回给客户端的js
	}
	
	//个人资料修改后提交的地址
	def grzl(){// gerenziliao-->个人资料
		def principal = SecurityUtils.subject?.principal
		def userInstance = ShiroUser.findByUsername(principal)
//		println("grzl");
//		println userInstance.username;
//		println(params.realname);
		userInstance.nickname = params.nickname;
		userInstance.realname = params.realname;
		userInstance.email = params.email;
		userInstance.weibo = params.weibo;
		userInstance.qq = params.qq;
		userInstance.weixin = params.weixin;
		userInstance.province = params.province_h;
		userInstance.city = params.city_h;
		userInstance.sex = params.sex;
		userInstance.save(flash:true);
//		println(params.sex);
//		println userInstance.province ;
		
		if (!userInstance.save(flush: true)) {
			render(view: "accout/1",model:[userInstance:userInstance]);
		}
		render(view: "accout/1",model:[userInstance:userInstance]);
//		println("local"+params.province_h+" "+params.city_h)
//		render(view: "accout/1",model:[userInstance:userInstance]);
	}
	
	def uniq_nick(){//JS检验昵称,呢称必须是唯一的
		def nickname = ShiroUser.findByNickname(params.nick);
		if(nickname){
			render 0;
		}else{
		render 1;
		}
	}
	
	def uniq_email(){
		def email = ShiroUser.findByEmail(params.email);
		if(email){
			render 0;
		}else{
			render 1;
		}
	}
	
	//保留，以后留着做ajax
//	def createJS(){
//		
//		def user = ShiroUser.findByUsername(params.username);
//		if(user){
//			println("用户名已存在");
//			render 1;
//		}else{
//			println("对");
//			render 0;
//		}
//		println(params.username);
//		return 
//	}
	
	

	
//	def photo(){ //美图秀秀开放平台
//		try{
//			String temp=(String)session.getId();//获得sessionId
//			String filetype = request.getParameter("filetype");
//			//System.out.println(filetype);
//			File f1=new File((String)request.getRealPath("photo")+"/","tmp"+temp);    //获得photo所在的目录，并加上sessionId
//			if (!f1.exists()) {
//				   f1.mkdirs();
//				}
//			//out.println(f1);
//			FileOutputStream o=new FileOutputStream(f1);//文件输出流指向上传文件所在路径
//			out.println(o);
//			InputStream ins=request.getInputStream();                                         //从客户端获得文件输入流
//			int n;
//			byte [] buffer = new byte[1024]
////			byte b[]=new byte[10000000];//设置缓冲数组的大小
//			byte [] b=new byte[10000000];//设置缓冲数组的大小
//			while((n=ins.read(b))!=-1){
//				o.write(b,0,n);                                                  //将数据从输入流读入到缓冲数组然后再从缓冲数组写入到文件中
//			}
//			o.close();
//			ins.close();                   //关闭输入流和文件输出流
//			 RandomAccessFile random=new RandomAccessFile(f1,"r");       //文件随机读取写入流
//			 int second=1;
//			 String secondLine=null;
//			 while(second<=2){
//			 secondLine=random.readLine();//读入临时文件名
//			 second++;
//			 }
//			 int position=secondLine.lastIndexOf('\\');
//			 String filename=new String((secondLine.substring(position+1,secondLine.length()-1)).getBytes("iso-8859-1"),   "gb2312");//去掉临时文件名中的sessionId，获得文件名，并用iso-8859-1编码， 避免出现中文乱码问题
//			 random.seek(0);
//			 long forthEnPosition=0;
//			 int forth=1;
//			 while((n=random.readByte())!=1&&forth<=4){
//				 if(n=='\n'){
//					  forthEnPosition=random.getFilePointer();
//					  forth++;
//				 }//去掉临时文件开头的4个'\n'字符
//			 }
//			 long currentTime=System.currentTimeMillis() ;
//			 String newFileName = "MT_"+Long.toString(currentTime);
//			 File f2=new File((String)request.getRealPath("photo")+"/", newFileName+"."+filetype);   //以文件的名创建另一个文件随机读取
//			 RandomAccessFile random2=new RandomAccessFile(f2,"rw");
//			 random.seek(random.length());
//			 long endPosition=random.getFilePointer(); //以文件的名创建另一个文件随机读取写入流
//			 int j=1;
//			 long mark=endPosition;
//			 while(mark<=0&&j<=6){  //去掉临时文件末尾的6个'\n'字符
//				mark--;
//				random.seek(mark);
//				n=random.readByte();
//				if(n=='\n'){
//					endPosition=random.getFilePointer();
//					j++;
//				}
//			  }
//			  random.seek(forthEnPosition);
//			  long startPosition=random.getFilePointer();
//			  while(startPosition<endPosition-1){//将临时文件去掉头尾后写入到新建的文件中
//				  n=random.readByte();
//				  random2.write(n);
//				  startPosition=random.getFilePointer();
//			  }
//			  random2.close();
//			  random.close();
//			  f1.delete();
//			  out.println("上传文件成功！");
//			  }catch(Exception e)  {
//				  out.println("上传文件失败！");
//			  }
//	}
//	
	
	
//	def upload(){//无截图功能头像上传
//		
//		def uploadedFile  = request.getFile("Member_headimg")
////		print uploadedFile
//		if(!uploadedFile.empty){
////			println "Class: ${uploadedFile.class}"
////			println "Name: ${uploadedFile.name}"
////			println "OriginalFileName: ${uploadedFile.originalFilename}"
////			println "Size: ${uploadedFile.size}"
////			println "ContentType: ${uploadedFile.contentType}"
//			
//			def webRootUrl = servletContext.getRealPath("/")
////			println webRootUrl
//			def principal = SecurityUtils.subject?.principal
//			def user=ShiroUser.findByUsername(principal)
////			print user.id
//			def userDir = new File(webRootUrl, "/images/touxiang/${user.username}")
//			userDir.mkdirs()
//			uploadedFile.transferTo( new File( userDir, uploadedFile.originalFilename))
//			user.touxiang = "/touxiang/${user.username}/${uploadedFile.originalFilename}"
//		}
//		
//		render(view: "accout/2");
//			}
}