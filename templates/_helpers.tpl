{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "finala.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "finala.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "finala.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{/* Required labels */}}
{{- define "finala.labels" -}}
heritage: {{ .Release.Service }}
release: {{ .Release.Name }}
chart: {{ .Chart.Name }}
app: "{{ template "finala.name" . }}"
{{- end -}}

{{- define "finala.annotations" -}}
statusbay.io/application-name: "{{ template "finala.name" . }}"
statusbay.io/progress-deadline-seconds: "300"
{{- end -}}

{{/* matchLabels */}}
{{- define "finala.matchLabels" -}}
release: {{ .Release.Name }}
app: "{{ template "finala.name" . }}"
{{- end -}}



{{- define "finala.elasticsearch.host" -}}
  {{- if eq .Values.storage.type "internal" -}}
    {{- printf "http://%s-elasticsearch:9200" (include "finala.fullname" .) -}}
  {{- else -}}
    {{- .Values.api.application.storage.elasticsearch.endpoint -}}
  {{- end -}}
{{- end -}}


{{- define "finala.environmentVars" -}}
{{- if .environmentVars -}}
{{- range $key, $value := .environmentVars }}
- name: {{ $key }}
  value: {{ $value | quote }}
{{- end -}}
{{- end -}}
{{- end -}}



