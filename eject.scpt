JsOsaDAS1.001.00bplist00?Vscript_Cfunction run() {
	app = Application.currentApplication()
	app.includeStandardAdditions = true;
	var finder = Application('Finder');
	
	var success = false;
	var theDisks = "";
	
	displayNotification("Eject", "Attempting to eject all mounted drives");
	
	try {
		var theDisks = finder.disks();
		var diskPaths = theDisks.flatMap(diskFilter);
		diskPaths.forEach(diskPath => app.doShellScript('/usr/sbin/diskutil unmount ' + diskPath));
	} catch (err) {
		displayNotification("Oops, could not eject disks");
		return;
	}
	
	displayNotification("Success", "All potential mounted drives ejected");
}


function diskFilter(diskObj) {
	var exceptions = ["GoogleDrive"];
	if (exceptions.includes(diskObj.name())) {
		return []; //Element removed by flattening
	}
	
	var url = diskObj.url().slice(7)
	if (url.includes("System") || url === '/') { //Ignore system disks
		return [];
	}
	
	return url.replaceAll('%20', '\\ ')
}


function displayNotification(title, subtitle="", message="") {	 
	app.displayNotification(message, {
    	soundName: "Frog",
		withTitle: title,
		subtitle: subtitle
	});
}                              Y jscr  ??ޭ