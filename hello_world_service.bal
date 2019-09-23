import ballerina/http;
import ballerina/log;

listener http:Listener helloWorldEndpoint = new (9090);

@http:ServiceConfig {basePath: "/hello"}
service helloWorld on helloWorldEndpoint {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/{name}"
    }
    resource function sayHello(http:Caller caller, http:Request req, string name) {
        http:Response res = new;
        res.setJsonPayload({name: <@untainted>name});

        var result = caller->respond(res);
        if (result is error) {
            log:printError("Error sending response", result);
        }
    }
}
