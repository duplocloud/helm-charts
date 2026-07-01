{{- define "aos.serviceAccountName" -}}
{{- .local | default .global | default (printf "%s-edit-user" .namespace) -}}
{{- end -}}
