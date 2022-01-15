if which R >/dev/null; then
	R --quiet -e 'source("init.R"); source("data_import.R"); runApp(launch.browser = TRUE)'
else
	echo "Cannot find R. Please install/configure R and try again."
fi
