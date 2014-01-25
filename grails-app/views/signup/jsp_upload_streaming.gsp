<%--<!-- <%@ page contentType="text/html;charset=gb2312" language="java"%> 
<%@ page import="java.io.*"%> 

<%  try{   
String temp=(String)session.getId();//获得sessionId
String filetype = request.getParameter("filetype");
//System.out.println(filetype);
File f1=new File((String)request.getRealPath("photo")+"/","tmp"+temp);    //获得photo所在的目录，并加上sessionId
if (!f1.exists()) {
       f1.mkdirs();
    }
//out.println(f1);
FileOutputStream o=new FileOutputStream(f1);//文件输出流指向上传文件所在路径   
out.println(o);
InputStream in=request.getInputStream();                                         //从客户端获得文件输入流   
int n;   
byte b[]=new byte[10000000];//设置缓冲数组的大小   
while((n=in.read(b))!=-1){   
	o.write(b,0,n);                                                  //将数据从输入流读入到缓冲数组然后再从缓冲数组写入到文件中   
}   
o.close();   
in.close();                   //关闭输入流和文件输出流   
 RandomAccessFile random=new RandomAccessFile(f1,"r");       //文件随机读取写入流   
 int second=1;   
 String secondLine=null;
 while(second<=2){    
 secondLine=random.readLine();//读入临时文件名    
 second++;   
 } 
 int position=secondLine.lastIndexOf('\\');   
 String filename=new String((secondLine.substring(position+1,secondLine.length()-1)).getBytes("iso-8859-1"),   "gb2312");//去掉临时文件名中的sessionId，获得文件名，并用iso-8859-1编码， 避免出现中文乱码问题 
 random.seek(0);   
 long forthEnPosition=0;   
 int forth=1;   
 while((n=random.readByte())!=1&&forth<=4){
     if(n=='\n'){
          forthEnPosition=random.getFilePointer();
          forth++;
     }//去掉临时文件开头的4个'\n'字符
 }
 long currentTime=System.currentTimeMillis() ;
 String newFileName = "MT_"+Long.toString(currentTime);
 File f2=new File((String)request.getRealPath("photo")+"/", newFileName+"."+filetype);   //以文件的名创建另一个文件随机读取
 RandomAccessFile random2=new RandomAccessFile(f2,"rw");                                                                                              
 random.seek(random.length());   
 long endPosition=random.getFilePointer(); //以文件的名创建另一个文件随机读取写入流   
 int j=1;
 long mark=endPosition;   
 while(mark<=0&&j<=6){  //去掉临时文件末尾的6个'\n'字符    
    mark--;
    random.seek(mark);    
    n=random.readByte();    
    if(n=='\n'){     
        endPosition=random.getFilePointer();
        j++;    
    }            
  }   
  random.seek(forthEnPosition);   
  long startPosition=random.getFilePointer();   
  while(startPosition<endPosition-1){//将临时文件去掉头尾后写入到新建的文件中    
      n=random.readByte();    
      random2.write(n);                                                      
      startPosition=random.getFilePointer();   
  }   
  random2.close();   
  random.close();   
  f1.delete();
  out.println("上传文件成功！"); 
  }catch(Exception e)  {   
      out.println("上传文件失败！");  
  } 
  %>
 -->--%>