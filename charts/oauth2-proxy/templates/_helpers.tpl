{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "oauth2-proxy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "oauth2-proxy.fullname" -}}
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
{{- define "oauth2-proxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Get the secret name.
*/}}
{{- define "oauth2-proxy.secretName" -}}
{{- if .Values.config.existingSecret -}}
{{- printf "%s" .Values.config.existingSecret -}}
{{- else -}}
{{- printf "%s" (include "oauth2-proxy.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Generate a right Ingress apiVersion
*/}}
{{- define "ingress.apiVersion" -}}
{{- if semverCompare ">=1.20-0" .Capabilities.KubeVersion.GitVersion -}}
networking.k8s.io/v1
{{- else if semverCompare ">=1.14-0" .Capabilities.KubeVersion.GitVersion -}}
networking.k8s.io/v1beta1
{{- else  -}}
extensions/v1
{{- end }}
{{- end -}}

