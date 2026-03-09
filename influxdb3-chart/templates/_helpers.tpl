{{- define "influxdb3-core.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "influxdb3-core.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := include "influxdb3-core.name" . -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "influxdb3-core.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" -}}
{{- end -}}

{{- define "influxdb3-core.labels" -}}
helm.sh/chart: {{ include "influxdb3-core.chart" . }}
app.kubernetes.io/name: {{ include "influxdb3-core.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "influxdb3-core.selectorLabels" -}}
app.kubernetes.io/name: {{ include "influxdb3-core.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "influxdb3-core.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "influxdb3-core.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{- define "influxdb3-core.secretName" -}}
{{- if .Values.influxdb.existingSecret -}}
{{- .Values.influxdb.existingSecret -}}
{{- else -}}
{{- printf "%s-auth" (include "influxdb3-core.fullname" .) -}}
{{- end -}}
{{- end -}}
