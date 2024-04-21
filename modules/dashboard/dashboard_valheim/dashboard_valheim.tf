
#Dashboard
resource "azurerm_portal_dashboard" "vm_dashboard" {
  name                = "${var.project}-${var.environment}-vm-metrics"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  tags = {
    environment = var.environment
    project     = var.project
  }
  dashboard_properties = <<DASH
{
    "lenses": {
      "0": {
        "order": 0,
        "parts": {
          "0": {
            "position": {
              "x": 0,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${data.azurerm_virtual_machine.virtual_machine.id}"
                          },
                          "name": "Percentage CPU",
                          "aggregationType": 4,
                          "namespace": "microsoft.compute/virtualmachines",
                          "metricVisualization": {
                            "displayName": "Percentage CPU"
                          }
                        }
                      ],
                      "title": "Avg Percentage CPU for ${data.azurerm_virtual_machine.virtual_machine.name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        }
                      },
                      "timespan": {
                        "relative": {
                          "duration": 86400000
                        },
                        "showUTCTime": false,
                        "grain": 1
                      }
                    }
                  },
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${data.azurerm_virtual_machine.virtual_machine.id}"
                          },
                          "name": "Percentage CPU",
                          "aggregationType": 4,
                          "namespace": "microsoft.compute/virtualmachines",
                          "metricVisualization": {
                            "displayName": "Percentage CPU"
                          }
                        }
                      ],
                      "title": "Avg Percentage CPU for ${data.azurerm_virtual_machine.virtual_machine.name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "1440m"
                  }
                }
              }
            }
          },
          "1": {
            "position": {
              "x": 6,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${data.azurerm_virtual_machine.virtual_machine.id}"
                          },
                          "name": "Available Memory Bytes",
                          "aggregationType": 4,
                          "namespace": "microsoft.compute/virtualmachines",
                          "metricVisualization": {
                            "displayName": "Available Memory Bytes (Preview)"
                          }
                        }
                      ],
                      "title": "Avg Available Memory Bytes (Preview) for ${data.azurerm_virtual_machine.virtual_machine.name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        }
                      },
                      "timespan": {
                        "relative": {
                          "duration": 86400000
                        },
                        "showUTCTime": false,
                        "grain": 1
                      }
                    }
                  },
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${data.azurerm_virtual_machine.virtual_machine.id}"
                          },
                          "name": "Available Memory Bytes",
                          "aggregationType": 4,
                          "namespace": "microsoft.compute/virtualmachines",
                          "metricVisualization": {
                            "displayName": "Available Memory Bytes (Preview)"
                          }
                        }
                      ],
                      "title": "Avg Available Memory Bytes (Preview) for ${data.azurerm_virtual_machine.virtual_machine.name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "1440m"
                  }
                }
              }
            }
          },
          "2": {
            "position": {
              "x": 12,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${data.azurerm_virtual_machine.virtual_machine.id}"
                          },
                          "name": "VmAvailabilityMetric",
                          "aggregationType": 4,
                          "namespace": "microsoft.compute/virtualmachines",
                          "metricVisualization": {
                            "displayName": "VM Availability Metric (Preview)"
                          }
                        }
                      ],
                      "title": "Avg VM Availability Metric (Preview) for ${data.azurerm_virtual_machine.virtual_machine.name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        }
                      },
                      "timespan": {
                        "relative": {
                          "duration": 86400000
                        },
                        "showUTCTime": false,
                        "grain": 1
                      }
                    }
                  },
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${data.azurerm_virtual_machine.virtual_machine.id}"
                          },
                          "name": "VmAvailabilityMetric",
                          "aggregationType": 4,
                          "namespace": "microsoft.compute/virtualmachines",
                          "metricVisualization": {
                            "displayName": "VM Availability Metric (Preview)"
                          }
                        }
                      ],
                      "title": "Avg VM Availability Metric (Preview) for ${data.azurerm_virtual_machine.virtual_machine.name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              },
              "filters": {
                "MsPortalFx_TimeRange": {
                  "model": {
                    "format": "local",
                    "granularity": "auto",
                    "relative": "1440m"
                  }
                }
              }
            }
          },
          "3": {
            "position": {
              "x": 0,
              "y": 4,
              "colSpan": 6,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "## OS Disk Free Space\n",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
                }
              }
            }
          },
          "4": {
            "position": {
              "x": 6,
              "y": 4,
              "colSpan": 6,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "## Valheim_server Process Memory\n",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
                }
              }
            }
          },
          "5": {
            "position": {
              "x": 12,
              "y": 4,
              "colSpan": 6,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "content": "## Valheim_server Process CPU\n",
                  "title": "",
                  "subtitle": "",
                  "markdownSource": 1,
                  "markdownUri": ""
                }
              }
            }
          },
          "6": {
            "position": {
              "x": 0,
              "y": 5,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "${data.azurerm_log_analytics_workspace.log_analytics_workspace.id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "38df4e16-3048-410c-a293-0925157c5629",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "Perf\n| where ObjectName == \"LogicalDisk\"\n| where CounterName == \"Free Megabytes\"\n| where InstanceName == \"C:\"\n| project\n    TimeGenerated,\n    Computer,\n    CounterValue\n| render timechart \n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Line",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${data.azurerm_log_analytics_workspace.log_analytics_workspace.name}",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "TimeGenerated",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "CounterValue",
                        "type": "real"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Computer",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {}
            }
          },
          "7": {
            "position": {
              "x": 6,
              "y": 5,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "${data.azurerm_log_analytics_workspace.log_analytics_workspace.id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "6e3ed8dc-169d-468d-a050-e7192c414131",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "Perf\n| where TimeGenerated > ago(1d)\n| where ObjectName == \"Process\"\n| where CounterName == \"Working Set - Private\"\n| where InstanceName == \"valheim_server\"\n| project\n    TimeGenerated,\n    Computer,\n    [\"Process\"]=InstanceName,\n    [\"MemoryBYtes\"]=CounterValue\n| render timechart \n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Line",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${data.azurerm_log_analytics_workspace.log_analytics_workspace.name}",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "TimeGenerated",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "MemoryBYtes",
                        "type": "real"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Computer",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": true,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {}
            }
          },
          "8": {
            "position": {
              "x": 12,
              "y": 5,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "${data.azurerm_log_analytics_workspace.log_analytics_workspace.id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "35dfea2b-1558-42da-a121-525c1929b99b",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "Perf\n| where TimeGenerated > ago(1d)\n| where ObjectName == \"Process\"\n| where CounterName == \"% Processor Time\"\n| where InstanceName == \"valheim_server\"\n| project\n    TimeGenerated,\n    Computer,\n    [\"CPU\"]=CounterValue\n| render timechart \n\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "Line",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${data.azurerm_log_analytics_workspace.log_analytics_workspace.name}",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "xAxis": {
                      "name": "TimeGenerated",
                      "type": "datetime"
                    },
                    "yAxis": [
                      {
                        "name": "CPU",
                        "type": "real"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Computer",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "value": {
                    "isEnabled": true,
                    "position": "Bottom"
                  },
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": true,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {}
            }
          }
        }
      }
    },
    "metadata": {
      "model": {
        "timeRange": {
          "value": {
            "relative": {
              "duration": 24,
              "timeUnit": 1
            }
          },
          "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        },
        "filterLocale": {
          "value": "en-us"
        },
        "filters": {
          "value": {
            "MsPortalFx_TimeRange": {
              "model": {
                "format": "local",
                "granularity": "auto",
                "relative": "24h"
              },
              "displayCache": {
                "name": "Local Time",
                "value": "Past 24 hours"
              },
              "filteredPartIds": [
                "StartboardPart-MonitorChartPart-1ff8df1e-e070-4380-b031-c43b82a4604d",
                "StartboardPart-MonitorChartPart-1ff8df1e-e070-4380-b031-c43b82a4604f",
                "StartboardPart-MonitorChartPart-1ff8df1e-e070-4380-b031-c43b82a46051",
                "StartboardPart-LogsDashboardPart-1ff8df1e-e070-4380-b031-c43b82a46059",
                "StartboardPart-LogsDashboardPart-1ff8df1e-e070-4380-b031-c43b82a4605d",
                "StartboardPart-LogsDashboardPart-1ff8df1e-e070-4380-b031-c43b82a4605f"
              ]
            }
          }
        }
      }
    },
  "name": "${var.project}-${var.environment} VM Metrics",
  "type": "Microsoft.Portal/dashboards",
  "location": "${data.azurerm_resource_group.resource_group.location}",
  "tags": {
    "hidden-title": "${var.project}-${var.environment} VM Metrics"
  },
  "apiVersion": "2015-08-01-preview"
}
DASH
}
