{{/*
Expand the name of the chart.
*/}}
{{- define "fs-gateway.name" -}}
{{- default "fs-gateway" (default .Values.nameOverride .Chart.Name) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fs-gateway.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "fs-gateway" (default .Values.nameOverride .Chart.Name) }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "fs-gateway.chart" -}}
{{- if .Chart }}
{{- printf "%s-%s" (default "fs-gateway" .Chart.Name) (default "0.1.0" .Chart.Version) | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- else }}
"fs-gateway-0.1.0" # Fallback if .Chart is nil
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fs-gateway.labels" -}}
helm.sh/chart: {{ include "fs-gateway.chart" . }}
app.kubernetes.io/name: {{ include "fs-gateway.name" . }}
app.kubernetes.io/instance: {{ .Release.Name | default "default-instance" }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service | default "Helm" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fs-gateway.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fs-gateway.name" . }}
app.kubernetes.io/instance: {{ .Release.Name | default "default-instance" }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fs-gateway.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "fs-gateway.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
