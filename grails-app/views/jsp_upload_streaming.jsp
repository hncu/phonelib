<%@ page contentType="text/html;charset=gb2312" language="java"%> 
<%@ page import="java.io.*"%> 

<%  try{   
String temp=(String)session.getId();//���sessionId
String filetype = request.getParameter("filetype");
//System.out.println(filetype);
File f1=new File((String)request.getRealPath("photo")+"/","tmp"+temp);    //���photo���ڵ�Ŀ¼��������sessionId
if (!f1.exists()) {
       f1.mkdirs();
    }
//out.println(f1);
FileOutputStream o=new FileOutputStream(f1);//�ļ������ָ���ϴ��ļ�����·��   
out.println(o);
InputStream in=request.getInputStream();                                         //�ӿͻ��˻���ļ�������   
int n;   
byte b[]=new byte[10000000];//���û�������Ĵ�С   
while((n=in.read(b))!=-1){   
	o.write(b,0,n);                                                  //�����ݴ����������뵽��������Ȼ���ٴӻ�������д�뵽�ļ���   
}   
o.close();   
in.close();                   //�ر����������ļ������   
 RandomAccessFile random=new RandomAccessFile(f1,"r");       //�ļ������ȡд����   
 int second=1;   
 String secondLine=null;
 while(second<=2){    
 secondLine=random.readLine();//������ʱ�ļ���    
 second++;   
 }   
 int position=secondLine.lastIndexOf('\\');   
 String filename=new String((secondLine.substring(position+1,secondLine.length()-1)).getBytes("iso-8859-1"),   "gb2312");//ȥ����ʱ�ļ����е�sessionId������ļ���������iso-8859-1���룬 ������������������� 
 random.seek(0);   
 long forthEnPosition=0;   
 int forth=1;   
 while((n=random.readByte())!=1&&forth<=4){
     if(n=='\n'){
          forthEnPosition=random.getFilePointer();
          forth++;
     }//ȥ����ʱ�ļ���ͷ��4��'\n'�ַ�
 }
 long currentTime=System.currentTimeMillis() ;
 String newFileName = "MT_"+Long.toString(currentTime);
 File f2=new File((String)request.getRealPath("photo")+"/", newFileName+"."+filetype);   //���ļ�����������һ���ļ������ȡ
 RandomAccessFile random2=new RandomAccessFile(f2,"rw");                                                                                              
 random.seek(random.length());   
 long endPosition=random.getFilePointer(); //���ļ�����������һ���ļ������ȡд����   
 int j=1;
 long mark=endPosition;   
 while(mark<=0&&j<=6){  //ȥ����ʱ�ļ�ĩβ��6��'\n'�ַ�    
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
  while(startPosition<endPosition-1){//����ʱ�ļ�ȥ��ͷβ��д�뵽�½����ļ���    
      n=random.readByte();    
      random2.write(n);                                                      
      startPosition=random.getFilePointer();   
  }   
  random2.close();   
  random.close();   
  f1.delete();
  out.println("�ϴ��ļ��ɹ���"); 
  }catch(Exception e)  {   
      out.println("�ϴ��ļ�ʧ�ܣ�");  
  } 
  %>
 