#!/bin/bash


function createJava() {
    package="$1"
    file="$2"
echo "
package $package;
import java.io.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = \"helloServlet\", value = \"/hello-servlet\")
public class Controller extends HttpServlet {
    private String message;

    public void init() {
        message = \"Hello World!\";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType(\"text/html\");

        // Hello
        PrintWriter out = response.getWriter();
        out.println(\"<html><body>\");
        out.println(\"<h1>\" + message + \"</h1>\");
        out.println(\"</body></html>\");
    }

    public void destroy() {
    }
}
" > "$file"
}
