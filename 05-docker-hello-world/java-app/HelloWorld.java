import com.sun.net.httpserver.HttpServer;

import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.file.Files;
import java.nio.file.Path;

public class HelloWorld {

    public static void main(String[] args) throws Exception {
        byte[] page = Files.readAllBytes(Path.of("index.html"));

        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0);

        server.createContext("/", exchange -> {
            exchange.getResponseHeaders().set("Content-Type", "text/html; charset=utf-8");
            exchange.sendResponseHeaders(200, page.length);
            OutputStream os = exchange.getResponseBody();
            os.write(page);
            os.close();
        });

        server.start();
        System.out.println("Java app listening on port 8080");
    }
}
