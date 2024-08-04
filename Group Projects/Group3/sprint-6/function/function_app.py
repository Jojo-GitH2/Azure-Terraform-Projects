import azure.functions as func
import logging
import re
import json

app = func.FunctionApp(http_auth_level=func.AuthLevel.FUNCTION)


@app.route(route="RemoveHTMLFunction")
def RemoveHTMLFunction(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("Python HTTP trigger function processed a request.")

    email_body_content = req.get_body().decode("utf-8")

    # Check if the request body is empty
    if not email_body_content.strip():
        return func.HttpResponse(
            body=json.dumps({"message": "No input provided"}),
            mimetype="application/json",
        )
    content = json.loads(email_body_content)

    # Remove HTML tags using regex
    updated_content = {
        key: re.sub("<.*?>", "", value, flags=re.DOTALL).replace("\\r\\n", " ")
        for key, value in content.items()
    }

    response_content = {"updatedBody": json.dumps(updated_content)}

    return func.HttpResponse(
        body=json.dumps(response_content), mimetype="application/json"
    )
