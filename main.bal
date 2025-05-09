import ballerina/http;
import ballerina/log;
import ballerinax/prometheus as _;

listener http:Listener deliveryListener = new (8080);

int counter = 100;

service /package on deliveryListener {

    resource function get track/[string trackingId]() returns json|error {
        log:printInfo("Tracking requested for: " + trackingId);

        if trackingId == "PKG123" {
            return {
                id: "PKG123",
                status: "In Transit",
                estimatedDelivery: "2025-05-07"
            };
        } else {
            return { message: "Package not found" };
        }
    }

    resource function post register(@http:Payload json payload) returns json {
        counter += 1;
        string id = "PKG" + counter.toString();

        return {
            message: "Package registered successfully",
            id: id,
            details: payload
        };
    }
}

