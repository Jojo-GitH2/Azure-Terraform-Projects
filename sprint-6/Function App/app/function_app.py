import azure.functions as func
import logging
from datetime import datetime
import random
import string
# import pytz

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.route(route="http_trigger")
def http_trigger(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("Python HTTP trigger function processed a request.")

    firstName = req.params.get("firstName")
    lastName = req.params.get("lastName")
    if not firstName and not lastName:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        # else:
        #     # name = req_body.get('name')
        #     pass 

    if firstName and lastName:
        random_string = "".join(
            random.choice(string.ascii_letters + string.digits) for _ in range(4)
        )
        return func.HttpResponse(
            "Generated Email Address: " + f"{firstName}.{lastName}.{random_string}@cloud.knixat.com".lower()
        )
    elif firstName or lastName:
        return func.HttpResponse(
        "Please provide both first name and last name for a personalized response. To test this function, try the following URL: https://<function_app_name>.azurewebsites.net/api/http_trigger?firstName=John&lastName=Doe ",
        status_code=400,
    )
    else:
        return func.HttpResponse(
            "This HTTP triggered function executed successfully. Pass your first name and last name in the query string or in the request body for a personalized response. To test this function, try the following URL: https://<function_app_name>.azurewebsites.net/api/http_trigger?firstName=John&lastName=Doe",
            status_code=200,
        )


@app.schedule(arg_name="timer", schedule="*/2 * * * *")
def timer(timer: func.TimerRequest) -> None:
    # utc_timestamp = datetime.utcnow().replace(tzinfo=pytz.UTC).isoformat()
    present_time = datetime.now().astimezone().isoformat()

    if timer.past_due:
        logging.info("The timer is past due!")

    logging.info("Python timer trigger function ran at %s", present_time)
