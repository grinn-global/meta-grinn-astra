do_install:append:grinn-astra-1680-platform() {
	install -m 0644 ${S}/qmls/sl1680-ai.qml  ${D}${qmldir}/
	install -m 0644 ${S}/qmls/panels/FaceDetection.qml ${D}${qmldir}/panels/FaceDetection.qml
	install -m 0644 ${S}/qmls/panels/ObjectDetection.qml ${D}${qmldir}/panels/ObjectDetection.qml
	install -m 0644 ${S}/qmls/panels/PoseEstimation.qml ${D}${qmldir}/panels/PoseEstimation.qml
	install -m 0644 ${S}/qmls/panels/MultiAi.qml ${D}${qmldir}/panels/MultiAi.qml
	install -m 0644 ${S}/qmls/panels/AIEncoding.qml ${D}${qmldir}/panels/AIEncoding.qml
	install -m 0644 ${S}/qmls/panels/SRSlideshow.qml ${D}${qmldir}/panels/SRSlideshow.qml
	install -m 0644 ${S}/qmls/panels/Superres.qml ${D}${qmldir}/panels/Superres.qml
	install -m 0644 ${S}/qmls/panels/FaceRecognition.qml ${D}${qmldir}/panels/FaceRecognition.qml
}
