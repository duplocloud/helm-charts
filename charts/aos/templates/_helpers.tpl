{{- define "aos.serviceAccountName" -}}
{{- .local | default .global | default (printf "%s-edit-user" .namespace) -}}
{{- end -}}

{{- define "aos.nodeSelector" -}}
{{- $v := .local | default .global -}}
{{- with $v -}}
nodeSelector:
{{- toYaml . | nindent 2 }}
{{- end -}}
{{- end -}}

{{- define "aos.tolerations" -}}
{{- $v := .local | default .global -}}
{{- with $v -}}
tolerations:
{{- toYaml . | nindent 2 }}
{{- end -}}
{{- end -}}
