package com.maninsoft.smart.appstore.servlet;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.maninsoft.smart.factory.SwManagerFactory;
import com.maninsoft.smart.market.manager.ISwmManager;
import com.maninsoft.smart.market.model.SwmProductFile;
import com.maninsoft.smart.server.model.IFileModel;

public class AppStoreDownloadServlet extends HttpServlet
{
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException 
    {
    	DataInputStream in = null;
    	ServletOutputStream op = null;
    	try{
    		String fileId = request.getParameter("fileId"); 
    		String userId = request.getParameter("userId"); 
    		
    		ISwmManager swmMgr = SwManagerFactory.getInstance().getSwmManager();
    		SwmProductFile swmFile = swmMgr.getProductFile(userId, fileId);
    		String file_name = swmFile.getFileName();
    		String file = swmFile.getFilePath();
    	
    		File                f        = new File(file);
    		int                 length   = 0;
    							op       = response.getOutputStream();
    		ServletContext      context  = getServletConfig().getServletContext();
    		String              mimetype = context.getMimeType( file );
    		
//    		response.setContentType( (mimetype != null) ? mimetype : "application/octet-stream" );
//    		response.setContentType("application/x-download");
    		response.setContentType("application/octet-stream" );
    		response.setContentLength( (int)f.length() );
//    		response.setHeader( "Content-Disposition", "attachment; filename=\"" + file_name + "\"" );
    		file_name = new String(file_name.getBytes(), response.getCharacterEncoding());
    		response.setHeader( "Content-Disposition", "attachment; filename=\"" + file_name + "\"" );
    		
    		byte[] bbuf = new byte[4096];
    		in = new DataInputStream(new FileInputStream(f));
    		
    		while ((in != null) && ((length = in.read(bbuf)) != -1))
    		{
    			op.write(bbuf,0,length);
    		}
    	}catch(Throwable t){
    		try{
    			if(in != null & op != null){
    				in.close();
    				op.flush();
    				op.close();
    			}			
    		}catch(Throwable th){
    		}
    	}
    }
}