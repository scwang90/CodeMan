<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   viewBox="0 0 ${drawable.viewportWidth} ${drawable.viewportHeight}">
    <#list drawable.paths as path>
        <path
                style="fill:${path.fillColor!string("#00000000")};"
                d="${path.pathData}"
        />
    </#list>
</svg>
