{{- /*
Return the serviceAccountName for a component.
Call with: include "aos.serviceAccountName" (dict "global" .Values.global.serviceAccountName "local" .Values.<component>.serviceAccountName "namespace" .Release.Namespace)
Fallback order:
  1) local (if non-empty)
  2) global (if non-empty)
  3) "<namespace>-edit-user"
*/ -}}
{{- define "aos.serviceAccountName" -}}
  {{- $local := .local -}}
  {{- $global := .global -}}
  {{- if and (typeIs "string" $local) (ne (trim $local) "") -}}
    {{- trim $local -}}
  {{- else if and (typeIs "string" $global) (ne (trim $global) "") -}}
    {{- trim $global -}}
  {{- else -}}
    {{- printf "%s-edit-user" .namespace -}}
  {{- end -}}
{{- end -}}

{{- /*
Return a rendered "nodeSelector:" block for a component, or nothing if neither is set.
Call with: include "aos.nodeSelector" (dict "global" .Values.global.nodeSelector "local" .Values.<component>.nodeSelector)
Fallback order:
  1) local (if non-empty)
  2) global (if non-empty)
Pipe the result through `nindent <N>` at the call site.
*/ -}}
{{- define "aos.nodeSelector" -}}
  {{- $ns := .local -}}
  {{- if not $ns -}}
    {{- $ns = .global -}}
  {{- end -}}
  {{- if $ns -}}
nodeSelector:
{{ toYaml $ns | indent 2 }}
  {{- end -}}
{{- end -}}

{{- /*
Return a rendered "tolerations:" block for a component, or nothing if neither is set.
Call with: include "aos.tolerations" (dict "global" .Values.global.tolerations "local" .Values.<component>.tolerations)
Fallback order:
  1) local (if non-empty)
  2) global (if non-empty)
Pipe the result through `nindent <N>` at the call site.
*/ -}}
{{- define "aos.tolerations" -}}
  {{- $tol := .local -}}
  {{- if not $tol -}}
    {{- $tol = .global -}}
  {{- end -}}
  {{- if $tol -}}
tolerations:
{{ toYaml $tol | indent 2 }}
  {{- end -}}
{{- end -}}
