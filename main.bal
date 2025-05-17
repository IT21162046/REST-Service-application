import ballerina/http;
import ballerina/log;
import ballerinax/prometheus as _;

listener http:Listener deliveryListener = new (8080);

int counter = 100;
map<json> packageStore = {}; // In-memory store for registered packages

service /package on deliveryListener {

    resource function get track/[string trackingId]() returns json|error {
        log:printInfo("Tracking requested for: " + trackingId);

        json? result = packageStore[trackingId];
        if result is json {
            return {
                id: trackingId,
                status: "In Transit",
                estimatedDelivery: "2025-05-07",
                details: result
            };
        } else {
            
        }
    }

    resource function post register(@http:Payload json payload) returns json {
        counter += 1;
        string id = "PKG" + counter.toString();

        packageStore[id] = payload;

        return {
            message: "Package registered successfully",
            id: id,
            details: payload
        };
    }
}