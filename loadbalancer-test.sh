echo "**********  Loadbalancer port test  **********"

port=$(sudo netstat -tlnp | grep nginx | grep -v tcp | awk '{print $4}' | cut -d ":" -f2)
if [ "$port"=="80" ]; then
	echo "Loadbalancer is listening on port 80"
else
	echo "Loadbalancer failure to listen on port 80"
fi

echo "**********  Webapp test  **********"

status_code=$(curl -sL -w "%{http_code}\\n" "http://localhost:80/" -o /dev/null)
if [ $status_code == 200 ]; then
	echo "Web applictaion is running fine. Status $status_code received."
else
	echo "Web application failure detected. Status $status_code received."
fi

echo "**********  App server 1 connectivity test  **********"

status_code=$(curl -sL -w "%{http_code}\\n" "http://webapp-1.test.com:9000/" -o /dev/null)
if [ $status_code == 200 ]; then
	echo "App server 1 is responding on port 9000. Status $status_code received."
else
	echo "App server 1 failed to respond on port 9000. Status $status_code received."
fi

echo "**********  App server 2 connectivity test  **********"

status_code=$(curl -sL -w "%{http_code}\\n" "http://webapp-2.test.com:9000/" -o /dev/null)
if [ $status_code == 200 ]; then
	echo "App server 2 is responding on port 9000. Status $status_code received."
else
	echo "App server 2 failed to respond on port 9000. Status $status_code received."
fi
