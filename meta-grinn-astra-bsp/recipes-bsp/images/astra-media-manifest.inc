IMAGE_CMD:synaimg:append:grinn-astra-261x-platform () {
	install -m 0644 ${DEPLOY_DIR_IMAGE}/manifest.yaml \
		${DEPLOY_DIR_IMAGE}/${SYNAIMG_DEPLOY_SUBDIR}/manifest.yaml
}
