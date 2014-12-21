if [ -d /home/developer/.eclipse ]; then
	sudo chown developer:developer /home/developer/.eclipse
fi
exec /opt/counterclockwise-0.31.1.STABLE001/Counterclockwise
