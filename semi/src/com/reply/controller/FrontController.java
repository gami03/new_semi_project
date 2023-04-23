package com.reply.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.action.*;


public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// �븳湲� 泥섎━ �옉�뾽 吏꾪뻾.
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		// getRequestURI() : "/�봽濡쒖젥�듃紐�/�뙆�씪紐�(*.do)" �씪�뒗 臾몄옄�뿴�쓣 諛섑솚�빐 二쇰뒗 硫붿꽌�뱶.
		String uri = request.getRequestURI();
		System.out.println("URI >>> " + uri);
		
		// getContextPath() : �쁽�옱 �봽濡쒖젥�듃紐낆쓣 臾몄옄�뿴濡� 諛섑솚�빐 二쇰뒗 硫붿꽌�뱶.
		String path = request.getContextPath();
		System.out.println("Path >>> " + path);
		
		String command = uri.substring(path.length() + 1);
		System.out.println("Command >>> " + command);
		
		Action action = null;
		ActionForward forward = null;
		
		Properties prop = new Properties();
		
		/*
		 * java.util.Propertise �겢�옒�뒪
		 * - Properties �겢�옒�뒪�뒗 HashTable�쓽 �븯�쐞(�옄�떇) �겢�옒�뒪.
		 * - 蹂댄넻�� �솚寃쎈��닔 諛� �냽�꽦 媛믪쓣 Properties �뙆�씪�뿉 ���옣�븯�뿬 �돺寃� �젒洹쇳븷 �닔 �엳�뒗 �옣�젏�씠 �엳�쓬.
		 * - Properties �뙆�씪�쓣 �씪�젴�쓽 �궎(key) - 媛�(value)�쓽 �븳 �뙇�쑝濡� �씠猷⑥뼱�졇 �엳�쓬.
		 * - 蹂댄넻�쓣 �뙆�씪�뿉 ���옣�쓣 �븯�뿬 �궗�슜�쓣 �븿. �뙆�씪 �씠由꾩쓣 *.properties �씪�뒗 �씠由꾩쑝濡� �걹�굹寃� �븿.
		 * - FileInputStream �겢�옒�뒪�뿉 Properties �뙆�씪�쓣 �씤�옄濡� �꽔�뼱�꽌 洹� �뒪�듃由쇱쑝濡쒕��꽣 �뙆�씪�쓣 媛��졇�삱 �븣
		 *   留롮씠 �궗�슜�쓣 �븿. �씤�옄濡� �뱾�뼱�삩 Properties �뙆�씪�쓣 �씫寃� �맖.
		 * - �씫�뼱 �뱾�씪 �븣 �궗�슜�븯�뒗 硫붿꽌�뱶�뒗 load() �씪�뒗 硫붿꽌�뱶瑜� �씠�슜�븯�뿬 �뙆�씪�쓣 �씫�뼱 �뱾�씠寃� �맖.
		 */
		
		String path2 = FrontController.class.getResource("").getPath();
	      

	    FileInputStream fis = new FileInputStream("D:\\git\\new_semi_project\\semi\\src\\com\\reply\\controller\\mapping.properties");

	      
		prop.load(fis);
		
		String value = prop.getProperty(command);
		System.out.println("value >>> " + value);
		
		if(value.substring(0, 7).equals("execute")) {
			StringTokenizer st = new StringTokenizer(value, "|");
			
			String url_1 = st.nextToken(); // "execute"
			String url_2 = st.nextToken(); // "�뙣�궎吏�紐�.�겢�옒�뒪紐�"
			
			/*
			 * �룞�쟻 媛앹껜 �깮�꽦 : newInstance()
			 * - Class 媛앹껜瑜� �씠�슜�븯硫� new �뿰�궛�옄�쓽 �궗�슜 �뾾�씠 �룞�쟻�쑝濡� 媛앹껜 �깮�꽦�씠 媛��뒫�븿.
			 * - 肄붾뱶 �옉�꽦 �떆�뿉 �겢�옒�뒪�쓽 �씠由꾩쓣 寃곗젙�븷 �닔 �뾾怨�,
			 *   �윴���엫(�떎�뻾) �떆�뿉 �겢�옒�뒪�쓽 �씠由꾩씠 寃곗젙�릺�뒗 寃쎌슦�뿉 �쑀�슜�븯寃� �궗�슜�씠 �맖.
			 * 
			 * - newInstance() 硫붿꽌�뱶�뒗 湲곕낯�깮�꽦�옄瑜� �샇異쒗빐�꽌
			 *   媛앹껜瑜� �깮�꽦�븯湲� �븣臾몄뿉 諛섎뱶�떆 �겢�옒�뒪�뿉 湲곕낯�깮�꽦�옄媛� 議댁옱�빐�빞 �븿.
			 *   �삁�쇅媛� 諛쒖깮�븷 �닔 �엳�뒗�뜲 �빐�떦 �겢�옒�뒪媛� 異붿긽�겢�옒�뒪�씠嫄곕굹 �씤�꽣�럹�씠�뒪�씪 寃쎌슦 諛쒖깮�븯怨�,
			 *   �삉 �븯�굹�쓽 �삁�쇅�뒗 �겢�옒�뒪�쓽 �깮�꽦�옄媛� �젒洹쇱젣�븳�옄濡� �씤�빐 �젒洹쇳븷 �닔 �뾾�뒗 寃쎌슦�뿉 諛쒖깮�쓣 �븿. 
			 *   �뵲�씪�꽌 �삁�쇅 泥섎━瑜� �빐 二쇱뼱�빞 �븿.
			 *   
			 * - 諛섑솚 ���엯�� Object ���엯�씠誘�濡� 留욊쾶 �삎蹂��솚�쓣 �빐 二쇰㈃
			 *   �릺吏�留�, �겢�옒�뒪�쓽 ���엯�쓣 紐⑤Ⅴ�뒗 �긽�깭�씠誘�濡� �삎蹂��솚�쓣 �빐 以� �닔媛� �뾾�쓬.
			 *   �씠�윭�븳 臾몄젣瑜� �빐寃고븯湲� �쐞�빐�꽌 �씤�꽣�럹�씠�뒪瑜� �궗�슜�븯�뒗 寃껋엫.
			 *   
			 * - Class.forName(class �씠由�)�� �뙆�씪誘명꽣濡� 諛쏆� class �씠由꾩뿉 �빐�떦�븯�뒗 �겢�옒�뒪瑜� 濡쒕뵫�븳 �썑�뿉, 
			 *   洹� �겢�옒�뒪�뿉 �빐�떦�븯�뒗 �씤�뒪�꽩�뒪瑜� 由ы꽩�빐 以�.
			 *   newInstance() 硫붿꽌�뱶�뒗 濡쒕뵫�븳 �겢�옒�뒪�쓽 媛앹껜瑜�  �깮�꽦�븯�뒗 硫붿꽌�뱶�씠怨�, 
			 *   �씠�젃寃� �깮�꽦�맂 媛앹껜瑜� �룞�쟻 媛앹껜 �깮�꽦�씠�씪怨� �븿.
			 */
			
			try {
				Class url = Class.forName(url_2);
				
				// action = (Action)url.newInstance();
				Constructor constructor = url.getConstructor();
				
				action = (Action)constructor.newInstance();
				
				forward = action.excute(request, response);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else { // value �뿉 �뱾�뼱�삩 媛믪씠 "execute" 媛� �븘�땶 寃쎌슦
			// view page 濡� �씠�룞
			forward = new ActionForward();
			
			forward.setRedirect(false);
			forward.setPath(value);
			
		}
		
		if(forward != null) {
			if(forward.isRedirect()) { // true �씤 寃쎌슦
				response.sendRedirect(forward.getPath());
			}else { // false �씤 寃쎌슦 view page濡� �씠�룞
				RequestDispatcher rd = request.getRequestDispatcher(forward.getPath());
				
				rd.forward(request, response);
			}
		}
		
		
	}

}
