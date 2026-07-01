{{- /*
Return the serviceAccountName for a component.
Call with: include "aos.serviceAccountName" (dict "root" . "component" "grafana")
Fallback order:
  1) .Values.<component>.serviceAccountName (if non-empty)
  2) .Values.global.serviceAccountName (if non-empty)
  3) "<Release.Namespace>-edit-user"
*/ -}}
{{- define "aos.serviceAccountName" -}}
  {{- $root := .root -}}
  {{- $component := .component -}}
  {{- $vals := $root.Values -}}

  {{- /* try component-specific value first */ -}}
  {{- $compSA := "" -}}
  {{- if and (hasKey $vals $component) (hasKey (index $vals $component) "serviceAccountName") -}}
    {{- $compSA = (index $vals $component "serviceAccountName") -}}
  {{- end -}}

  {{- /* treat empty string or whitespace as not set */ -}}
  {{- if and (typeIs "string" $compSA) (ne (trim $compSA) "") -}}
    {{- trim $compSA -}}
  {{- else if and (hasKey $vals "global") (hasKey $vals.global "serviceAccountName") (ne (trim $vals.global.serviceAccountName) "") -}}
    {{- trim $vals.global.serviceAccountName -}}
  {{- else -}}
    {{- printf "%s-edit-user" $root.Release.Namespace -}}
  {{- end -}}
{{- end -}}
