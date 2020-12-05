<%@ page contentType= "text/html; charset=utf-8" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>

<%
   request.setCharacterEncoding("UTF-8");

   String filename = "";
   String realFolder = "D:\\upload";   //웹어플리케이션의 절대경로
   String encType = "utf-8";      //인코딩유형
   int maxSize = 5*1024*1024;      //최대 업로드도리 파이르이 크기 5MB
   
   
   MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
   
   String productId = multi.getParameter("productId");
   String name = multi.getParameter("name");
   String unitPrice = multi.getParameter("unitPrice");
   String description = multi.getParameter("description");
   String manufacturer = multi.getParameter("manufacturer");
   String category = multi.getParameter("category");
   String unitsInStock = multi.getParameter("unitsInStock");
   String condition = multi.getParameter("condition");
   
   
   Integer price;
   
   if(unitPrice.isEmpty())
       price = 0;
    else
       price = Integer.valueOf(unitPrice);
    
    long stock;
    
    if(unitsInStock.isEmpty())
       stock=0;
    else
       stock = Long.valueOf(unitsInStock);
    
    Enumeration files = multi.getFileNames();
    String fname = (String)files.nextElement();    // String 타입변환
    String fileName = multi.getFilesystemName(fname);
       
    ProductRepository dao = ProductRepository.getInstance();
    
    Product newProduct = new Product();
    newProduct.setProductId(productId);
    newProduct.setPname(name);
    newProduct.setDescription(description);
    newProduct.setManufacturer(manufacturer);
    newProduct.setUnitPrice(price);
    newProduct.setCategory(category);
    newProduct.setUnitsInstock(stock);
    newProduct.setCondition(condition);
    newProduct.setFilename(fileName);
    
    
    dao.addProduct(newProduct);
    
    response.sendRedirect("products.jsp");
%>