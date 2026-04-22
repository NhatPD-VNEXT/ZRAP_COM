"! <p class="shorttext synchronized">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>BC_EXT_APPJOB_MANAGEMENT</em>
CLASS zsc_od_sap_com_0326 DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized">Types for "OData Primitive Types"</p>
      BEGIN OF tys_types_for_prim_types,
        "! Used for primitive type CREATION_TIME_FROM
        creation_time_from         TYPE timestamp,
        "! Used for primitive type CREATION_TIME_TO
        creation_time_to           TYPE timestamp,
        "! Used for primitive type JOB_COUNT
        job_count                  TYPE c LENGTH 32,
        "! Used for primitive type JOB_COUNT_2
        job_count_2                TYPE string,
        "! Used for primitive type JOB_CREATOR
        job_creator                TYPE c LENGTH 12,
        "! Used for primitive type JOB_NAME
        job_name                   TYPE c LENGTH 32,
        "! Used for primitive type JOB_NAME_2
        job_name_2                 TYPE c LENGTH 32,
        "! Used for primitive type JOB_NAME_3
        job_name_3                 TYPE c LENGTH 32,
        "! Used for primitive type JOB_NAME_4
        job_name_4                 TYPE c LENGTH 32,
        "! Used for primitive type JOB_NAME_5
        job_name_5                 TYPE string,
        "! Used for primitive type JOB_NAME_6
        job_name_6                 TYPE string,
        "! Used for primitive type JOB_NAME_7
        job_name_7                 TYPE c LENGTH 14,
        "! Used for primitive type JOB_NAME_8
        job_name_8                 TYPE string,
        "! Used for primitive type JOB_PARAMETER_VALUES
        job_parameter_values       TYPE string,
        "! Used for primitive type JOB_PARAMETER_VALUES_2
        job_parameter_values_2     TYPE string,
        "! Used for primitive type JOB_PARAMETER_VALUES_SIMPL
        job_parameter_values_simpl TYPE string,
        "! Used for primitive type JOB_PARAMETER_VALUES_SIM_2
        job_parameter_values_sim_2 TYPE string,
        "! Used for primitive type JOB_RESTART_MODE
        job_restart_mode           TYPE string,
        "! Used for primitive type JOB_RUN_COUNT
        job_run_count              TYPE c LENGTH 8,
        "! Used for primitive type JOB_RUN_COUNT_2
        job_run_count_2            TYPE c LENGTH 14,
        "! Used for primitive type JOB_RUN_COUNT_3
        job_run_count_3            TYPE c LENGTH 14,
        "! Used for primitive type JOB_RUN_COUNT_4
        job_run_count_4            TYPE string,
        "! Used for primitive type JOB_RUN_COUNT_5
        job_run_count_5            TYPE string,
        "! Used for primitive type JOB_TEMPLATE_NAME
        job_template_name          TYPE c LENGTH 40,
        "! Used for primitive type JOB_TEMPLATE_NAME_2
        job_template_name_2        TYPE c LENGTH 40,
        "! Used for primitive type JOB_TEMPLATE_NAME_3
        job_template_name_3        TYPE c LENGTH 40,
        "! Used for primitive type JOB_TEMPLATE_NAME_4
        job_template_name_4        TYPE c LENGTH 40,
        "! Used for primitive type JOB_TEMPLATE_NAME_5
        job_template_name_5        TYPE c LENGTH 40,
        "! Used for primitive type JOB_TEXT
        job_text                   TYPE c LENGTH 120,
        "! Used for primitive type JOB_TEXT_2
        job_text_2                 TYPE c LENGTH 120,
        "! Used for primitive type JOB_USER
        job_user                   TYPE c LENGTH 40,
        "! Used for primitive type JOB_USER_2
        job_user_2                 TYPE c LENGTH 40,
        "! Used for primitive type JOB_USER_ID
        job_user_id                TYPE c LENGTH 12,
        "! Used for primitive type JOB_USER_NAME
        job_user_name              TYPE c LENGTH 40,
        "! Used for primitive type REPORT
        report                     TYPE c LENGTH 40,
        "! Used for primitive type TEMPLATE_NAME
        template_name              TYPE c LENGTH 40,
        "! Used for primitive type TEST_MODE_IND
        test_mode_ind              TYPE abap_bool,
        "! Used for primitive type VARIANT
        variant                    TYPE c LENGTH 14,
      END OF tys_types_for_prim_types.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function JobinfoGet</p>
      "! <em>with the internal name</em> JOBINFO_GET
      BEGIN OF tys_parameters_1,
        "! JobName
        job_name      TYPE c LENGTH 32,
        "! JobRunCount
        job_run_count TYPE c LENGTH 8,
      END OF tys_parameters_1,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_1</p>
      tyt_parameters_1 TYPE STANDARD TABLE OF tys_parameters_1 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function JobStatusGet</p>
      "! <em>with the internal name</em> JOB_STATUS_GET
      BEGIN OF tys_parameters_2,
        "! JobName
        job_name      TYPE string,
        "! JobRunCount
        job_run_count TYPE string,
      END OF tys_parameters_2,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_2</p>
      tyt_parameters_2 TYPE STANDARD TABLE OF tys_parameters_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function JobTemplateRead</p>
      "! <em>with the internal name</em> JOB_TEMPLATE_READ
      BEGIN OF tys_parameters_3,
        "! JobTemplateName
        job_template_name TYPE c LENGTH 40,
      END OF tys_parameters_3,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_3</p>
      tyt_parameters_3 TYPE STANDARD TABLE OF tys_parameters_3 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function TemplateValuesGet</p>
      "! <em>with the internal name</em> TEMPLATE_VALUES_GET
      BEGIN OF tys_parameters_4,
        "! JobTemplateName
        job_template_name TYPE c LENGTH 40,
      END OF tys_parameters_4,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_4</p>
      tyt_parameters_4 TYPE STANDARD TABLE OF tys_parameters_4 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function TemplateValuesStructGet</p>
      "! <em>with the internal name</em> TEMPLATE_VALUES_STRUCT_GET
      BEGIN OF tys_parameters_5,
        "! JobTemplateName
        job_template_name TYPE c LENGTH 40,
      END OF tys_parameters_5,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_5</p>
      tyt_parameters_5 TYPE STANDARD TABLE OF tys_parameters_5 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function JobAbort</p>
      "! <em>with the internal name</em> JOB_ABORT
      BEGIN OF tys_parameters_6,
        "! JobRunCount
        job_run_count TYPE c LENGTH 14,
        "! JobName
        job_name      TYPE c LENGTH 32,
      END OF tys_parameters_6,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_6</p>
      tyt_parameters_6 TYPE STANDARD TABLE OF tys_parameters_6 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function JobCancel</p>
      "! <em>with the internal name</em> JOB_CANCEL
      BEGIN OF tys_parameters_7,
        "! JobRunCount
        job_run_count TYPE c LENGTH 14,
        "! JobName
        job_name      TYPE c LENGTH 32,
      END OF tys_parameters_7,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_7</p>
      tyt_parameters_7 TYPE STANDARD TABLE OF tys_parameters_7 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function JobListGet</p>
      "! <em>with the internal name</em> JOB_LIST_GET
      BEGIN OF tys_parameters_8,
        "! JobText
        job_text           TYPE c LENGTH 120,
        "! CreationTimeFrom
        creation_time_from TYPE timestamp,
        "! CreationTimeTo
        creation_time_to   TYPE timestamp,
        "! TemplateName
        template_name      TYPE c LENGTH 40,
        "! JobCreator
        job_creator        TYPE c LENGTH 12,
        "! Report
        report             TYPE c LENGTH 40,
        "! Variant
        variant            TYPE c LENGTH 14,
        "! JobName
        job_name           TYPE c LENGTH 32,
      END OF tys_parameters_8,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_8</p>
      tyt_parameters_8 TYPE STANDARD TABLE OF tys_parameters_8 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function JobParamValuesGet</p>
      "! <em>with the internal name</em> JOB_PARAM_VALUES_GET
      BEGIN OF tys_parameters_9,
        "! JobName
        job_name  TYPE c LENGTH 14,
        "! JobCount
        job_count TYPE c LENGTH 32,
      END OF tys_parameters_9,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_9</p>
      tyt_parameters_9 TYPE STANDARD TABLE OF tys_parameters_9 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function JobParamValuesStructGet</p>
      "! <em>with the internal name</em> JOB_PARAM_VALUES_STRUCT_GE
      BEGIN OF tys_parameters_10,
        "! JobName
        job_name  TYPE string,
        "! JobCount
        job_count TYPE string,
      END OF tys_parameters_10,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_10</p>
      tyt_parameters_10 TYPE STANDARD TABLE OF tys_parameters_10 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function JobRestart</p>
      "! <em>with the internal name</em> JOB_RESTART
      BEGIN OF tys_parameters_11,
        "! JobName
        job_name         TYPE string,
        "! JobRunCount
        job_run_count    TYPE string,
        "! JobRestartMode
        job_restart_mode TYPE string,
      END OF tys_parameters_11,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_11</p>
      tyt_parameters_11 TYPE STANDARD TABLE OF tys_parameters_11 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function JobSchedule</p>
      "! <em>with the internal name</em> JOB_SCHEDULE
      BEGIN OF tys_parameters_12,
        "! JobUserID
        job_user_id                TYPE c LENGTH 12,
        "! JobUserName
        job_user_name              TYPE c LENGTH 40,
        "! JobText
        job_text                   TYPE c LENGTH 120,
        "! JobTemplateName
        job_template_name          TYPE c LENGTH 40,
        "! JobParameterValues
        job_parameter_values       TYPE string,
        "! TestModeInd
        test_mode_ind              TYPE abap_bool,
        "! JobUser
        job_user                   TYPE c LENGTH 40,
        "! JobParameterValuesSimple
        job_parameter_values_simpl TYPE string,
      END OF tys_parameters_12,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_12</p>
      tyt_parameters_12 TYPE STANDARD TABLE OF tys_parameters_12 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Parameters of function JobScheduleCheck</p>
      "! <em>with the internal name</em> JOB_SCHEDULE_CHECK
      BEGIN OF tys_parameters_13,
        "! JobUser
        job_user                   TYPE c LENGTH 40,
        "! JobParameterValues
        job_parameter_values       TYPE string,
        "! JobTemplateName
        job_template_name          TYPE c LENGTH 40,
        "! JobParameterValuesSimple
        job_parameter_values_simpl TYPE string,
      END OF tys_parameters_13,
      "! <p class="shorttext synchronized">List of TYS_PARAMETERS_13</p>
      tyt_parameters_13 TYPE STANDARD TABLE OF tys_parameters_13 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">ApplicationLogHeader</p>
      BEGIN OF tys_application_log_header,
        "! JobName
        job_name                   TYPE c LENGTH 32,
        "! JobTemplateName
        job_template_name          TYPE c LENGTH 40,
        "! SeverityText
        severity_text              TYPE c LENGTH 100,
        "! Text
        text                       TYPE string,
        "! JobCount
        job_count                  TYPE c LENGTH 8,
        "! SubObjectText
        sub_object_text            TYPE c LENGTH 60,
        "! SubObject
        sub_object                 TYPE c LENGTH 20,
        "! Severity
        severity                   TYPE c LENGTH 1,
        "! ObjectText
        object_text                TYPE c LENGTH 60,
        "! Object
        object                     TYPE c LENGTH 20,
        "! MessageContextField5Type
        message_context_field_5_ty TYPE c LENGTH 1,
        "! MessageContextField4Type
        message_context_field_4_ty TYPE c LENGTH 1,
        "! MessageContextField3Type
        message_context_field_3_ty TYPE c LENGTH 1,
        "! MessageContextField2Type
        message_context_field_2_ty TYPE c LENGTH 1,
        "! MessageContextField1Type
        message_context_field_1_ty TYPE c LENGTH 1,
        "! MessageTotalCount
        message_total_count        TYPE int4,
        "! MessageCountW
        message_count_w            TYPE int4,
        "! MessageCountS
        message_count_s            TYPE int4,
        "! MessageCountI
        message_count_i            TYPE int4,
        "! MessageCountE
        message_count_e            TYPE int4,
        "! MessageCountA
        message_count_a            TYPE int4,
        "! MessageContextField5Label
        message_context_field_5_la TYPE string,
        "! MessageContextField4Label
        message_context_field_4_la TYPE string,
        "! MessageContextField3Label
        message_context_field_3_la TYPE string,
        "! MessageContextField2Label
        message_context_field_2_la TYPE string,
        "! MessageContextField1Label
        message_context_field_1_la TYPE string,
        "! LogNumber
        log_number                 TYPE c LENGTH 20,
        "! <em>Key property</em> LogHandle
        log_handle                 TYPE c LENGTH 22,
        "! LastChangedUser
        last_changed_user          TYPE c LENGTH 12,
        "! LastChangedTime
        last_changed_time          TYPE timn,
        "! LastChangedDate
        last_changed_date          TYPE timestampl,
        "! HasMessageContextField5
        has_message_context_field  TYPE abap_bool,
        "! HasMessageContextField4
        has_message_context_fiel_2 TYPE abap_bool,
        "! HasMessageContextField3
        has_message_context_fiel_3 TYPE abap_bool,
        "! HasMessageContextField2
        has_message_context_fiel_4 TYPE abap_bool,
        "! HasMessageContextField1
        has_message_context_fiel_5 TYPE abap_bool,
        "! ExternalNumber
        external_number            TYPE c LENGTH 100,
        "! ExpirationDate
        expiration_date            TYPE timestampl,
        "! CreatedByUser
        created_by_user            TYPE c LENGTH 12,
        "! CreatedByFormattedName
        created_by_formatted_name  TYPE c LENGTH 255,
        "! CreatedAtTime
        created_at_time            TYPE timn,
        "! CreatedAtDate
        created_at_date            TYPE timestampl,
        "! CreatedAt
        created_at                 TYPE timestamp,
      END OF tys_application_log_header,
      "! <p class="shorttext synchronized">List of ApplicationLogHeader</p>
      tyt_application_log_header TYPE STANDARD TABLE OF tys_application_log_header WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">ApplicationLogMessage</p>
      BEGIN OF tys_application_log_message,
        "! ContextField1
        context_field_1    TYPE c LENGTH 256,
        "! FilterFieldName
        filter_field_name  TYPE c LENGTH 30,
        "! FilterFieldValue
        filter_field_value TYPE c LENGTH 100,
        "! TypeText
        type_text          TYPE string,
        "! DetailLevel
        detail_level       TYPE c LENGTH 1,
        "! ContextField2
        context_field_2    TYPE c LENGTH 256,
        "! ContextField3
        context_field_3    TYPE c LENGTH 256,
        "! HasDetailText
        has_detail_text    TYPE abap_bool,
        "! ContextField4
        context_field_4    TYPE c LENGTH 256,
        "! ContextField5
        context_field_5    TYPE c LENGTH 256,
        "! <em>Key property</em> LogHandle
        log_handle         TYPE c LENGTH 22,
        "! <em>Key property</em> MessageNumber
        message_number     TYPE c LENGTH 6,
        "! Timestamp
        timestamp          TYPE timestampl,
        "! Type
        type               TYPE c LENGTH 1,
        "! Text
        text               TYPE string,
        "! HasLongText
        has_long_text      TYPE abap_bool,
      END OF tys_application_log_message,
      "! <p class="shorttext synchronized">List of ApplicationLogMessage</p>
      tyt_application_log_message TYPE STANDARD TABLE OF tys_application_log_message WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">FuncImpReturn</p>
      BEGIN OF tys_func_imp_return,
        "! <em>Key property</em> ReturnCode
        return_code TYPE int2,
      END OF tys_func_imp_return,
      "! <p class="shorttext synchronized">List of FuncImpReturn</p>
      tyt_func_imp_return TYPE STANDARD TABLE OF tys_func_imp_return WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Jobinfo</p>
      BEGIN OF tys_jobinfo,
        "! <em>Key property</em> JobName
        job_name             TYPE c LENGTH 32,
        "! <em>Key property</em> JobRunCount
        job_run_count        TYPE c LENGTH 8,
        "! JobStatus
        job_status           TYPE c LENGTH 1,
        "! JobSdlDateTime
        job_sdl_date_time    TYPE timestamp,
        "! JobStartDateTime
        job_start_date_time  TYPE timestamp,
        "! JobEndDateTime
        job_end_date_time    TYPE timestamp,
        "! JobAppRC
        job_app_rc           TYPE int4,
        "! <em>Key property</em> StepCount
        step_count           TYPE int4,
        "! StepStatus
        step_status          TYPE c LENGTH 1,
        "! StepStartDateTime
        step_start_date_time TYPE timestamp,
        "! StepAppRC
        step_app_rc          TYPE int4,
      END OF tys_jobinfo,
      "! <p class="shorttext synchronized">List of Jobinfo</p>
      tyt_jobinfo TYPE STANDARD TABLE OF tys_jobinfo WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">Joblist</p>
      BEGIN OF tys_joblist,
        "! <em>Key property</em> JobName
        job_name             TYPE c LENGTH 32,
        "! <em>Key property</em> JobRunCount
        job_run_count        TYPE c LENGTH 8,
        "! JobText
        job_text             TYPE c LENGTH 120,
        "! TemplateName
        template_name        TYPE c LENGTH 40,
        "! JobCreator
        job_creator          TYPE c LENGTH 12,
        "! Report
        report               TYPE c LENGTH 40,
        "! Variant
        variant              TYPE c LENGTH 14,
        "! NrSteps
        nr_steps             TYPE int4,
        "! JobStatus
        job_status           TYPE c LENGTH 1,
        "! JobLogStatus
        job_log_status       TYPE c LENGTH 1,
        "! JobCreaDateTime
        job_crea_date_time   TYPE timestamp,
        "! JobSchedDateTime
        job_sched_date_time  TYPE timestamp,
        "! JobStartDateTime
        job_start_date_time  TYPE timestamp,
        "! JobEndDateTime
        job_end_date_time    TYPE timestamp,
        "! JobAppRC
        job_app_rc           TYPE int4,
        "! StepStatus
        step_status          TYPE c LENGTH 1,
        "! StepStartDateTime
        step_start_date_time TYPE timestamp,
        "! StepApRC
        step_ap_rc           TYPE int4,
      END OF tys_joblist,
      "! <p class="shorttext synchronized">List of Joblist</p>
      tyt_joblist TYPE STANDARD TABLE OF tys_joblist WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobHeader</p>
      BEGIN OF tys_job_header,
        "! <em>Key property</em> JobName
        job_name                   TYPE c LENGTH 32,
        "! <em>Key property</em> JobRunCount
        job_run_count              TYPE c LENGTH 8,
        "! JobText
        job_text                   TYPE string,
        "! JobTemplateName
        job_template_name          TYPE c LENGTH 40,
        "! JobTemplateText
        job_template_text          TYPE c LENGTH 120,
        "! JobSeriesCreatedAt
        job_series_created_at      TYPE c LENGTH 20,
        "! JobCreatedBy
        job_created_by             TYPE c LENGTH 12,
        "! JobStatus
        job_status                 TYPE c LENGTH 1,
        "! JobPlannedStartDateTime
        job_planned_start_date_tim TYPE c LENGTH 20,
        "! JobCreaDateTime
        job_crea_date_time         TYPE c LENGTH 20,
        "! JobStartDateTime
        job_start_date_time        TYPE c LENGTH 20,
        "! JobEndDateTime
        job_end_date_time          TYPE c LENGTH 20,
        "! Periodic
        periodic                   TYPE abap_bool,
        "! PeriodicMinutes
        periodic_minutes           TYPE c LENGTH 2,
        "! PeriodicHours
        periodic_hours             TYPE c LENGTH 2,
        "! PeriodicDays
        periodic_days              TYPE c LENGTH 3,
        "! PeriodicWeeks
        periodic_weeks             TYPE c LENGTH 2,
        "! PeriodicMonths
        periodic_months            TYPE c LENGTH 2,
        "! JobStepCount
        job_step_count             TYPE int4,
        "! JobCreatedByFormattedName
        job_created_by_formatted_n TYPE c LENGTH 80,
        "! JobEndMaxIterations
        job_end_max_iterations     TYPE int4,
        "! TaskEndDateTime
        task_end_date_time         TYPE c LENGTH 20,
        "! FactoryCalendar
        factory_calendar           TYPE c LENGTH 2,
        "! StartRestrictionCode
        start_restriction_code     TYPE c LENGTH 1,
        "! TaskWeekDay
        task_week_day              TYPE c LENGTH 7,
        "! TaskWorkDayNo
        task_work_day_no           TYPE c LENGTH 2,
        "! TaskWorkDirCdir
        task_work_dir_cdir         TYPE c LENGTH 2,
        "! TaskUseWorkdaysInd
        task_use_workdays_ind      TYPE abap_bool,
        "! TimeZone
        time_zone                  TYPE c LENGTH 6,
        "! JobHasResults
        job_has_results            TYPE abap_bool,
        "! OrigJobName
        orig_job_name              TYPE c LENGTH 32,
        "! OrigJobCount
        orig_job_count             TYPE c LENGTH 8,
        "! JobRestartCount
        job_restart_count          TYPE int4,
        "! JobRunRestartMode
        job_run_restart_mode       TYPE c LENGTH 1,
      END OF tys_job_header,
      "! <p class="shorttext synchronized">List of JobHeader</p>
      tyt_job_header TYPE STANDARD TABLE OF tys_job_header WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobLog</p>
      BEGIN OF tys_job_log,
        "! <em>Key property</em> JobName
        job_name    TYPE c LENGTH 32,
        "! <em>Key property</em> JobCount
        job_count   TYPE c LENGTH 14,
        "! <em>Key property</em> StepNumber
        step_number TYPE int4,
        "! <em>Key property</em> LogHandle
        log_handle  TYPE c LENGTH 22,
      END OF tys_job_log,
      "! <p class="shorttext synchronized">List of JobLog</p>
      tyt_job_log TYPE STANDARD TABLE OF tys_job_log WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobLogMessage</p>
      BEGIN OF tys_job_log_message,
        "! <em>Key property</em> JobName
        job_name      TYPE c LENGTH 32,
        "! <em>Key property</em> JobRunCount
        job_run_count TYPE c LENGTH 8,
        "! <em>Key property</em> StepNumber
        step_number   TYPE int4,
        "! <em>Key property</em> LogHandle
        log_handle    TYPE c LENGTH 22,
        "! <em>Key property</em> MsgNumber
        msg_number    TYPE c LENGTH 6,
        "! MsgType
        msg_type      TYPE c LENGTH 1,
        "! MsgId
        msg_id        TYPE c LENGTH 20,
        "! MsgNo
        msg_no        TYPE c LENGTH 3,
        "! MsgV1
        msg_v_1       TYPE string,
        "! MsgV2
        msg_v_2       TYPE c LENGTH 50,
        "! MsgV3
        msg_v_3       TYPE c LENGTH 50,
        "! MsgV4
        msg_v_4       TYPE c LENGTH 50,
        "! MsgText
        msg_text      TYPE string,
      END OF tys_job_log_message,
      "! <p class="shorttext synchronized">List of JobLogMessage</p>
      tyt_job_log_message TYPE STANDARD TABLE OF tys_job_log_message WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobParamValues</p>
      BEGIN OF tys_job_param_values,
        "! <em>Key property</em> ParameterValues
        parameter_values TYPE string,
      END OF tys_job_param_values,
      "! <p class="shorttext synchronized">List of JobParamValues</p>
      tyt_job_param_values TYPE STANDARD TABLE OF tys_job_param_values WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobParamValuesStruct</p>
      BEGIN OF tys_job_param_values_struct,
        "! <em>Key property</em> StepNr
        step_nr            TYPE int4,
        "! <em>Key property</em> JobParameterName
        job_parameter_name TYPE c LENGTH 38,
        "! Sign
        sign               TYPE c LENGTH 1,
        "! Option
        option             TYPE c LENGTH 2,
        "! Low
        low                TYPE c LENGTH 255,
        "! High
        high               TYPE c LENGTH 255,
      END OF tys_job_param_values_struct,
      "! <p class="shorttext synchronized">List of JobParamValuesStruct</p>
      tyt_job_param_values_struct TYPE STANDARD TABLE OF tys_job_param_values_struct WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobScheduleCheck</p>
      BEGIN OF tys_job_schedule_check_3,
        "! JobParameterValues
        job_parameter_values TYPE string,
        "! <em>Key property</em> SuccessfulInd
        successful_ind       TYPE abap_bool,
        "! ChangedInd
        changed_ind          TYPE abap_bool,
        "! DynamicProperties
        dynamic_properties   TYPE string,
        "! ErrMessages
        err_messages         TYPE string,
      END OF tys_job_schedule_check_3,
      "! <p class="shorttext synchronized">List of JobScheduleCheck</p>
      tyt_job_schedule_check_3 TYPE STANDARD TABLE OF tys_job_schedule_check_3 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobScheduleStatus</p>
      BEGIN OF tys_job_schedule_status,
        "! <em>Key property</em> JobName
        job_name      TYPE c LENGTH 32,
        "! <em>Key property</em> JobRunCount
        job_run_count TYPE c LENGTH 8,
        "! JobStatus
        job_status    TYPE c LENGTH 1,
        "! ReturnCode
        return_code   TYPE int2,
      END OF tys_job_schedule_status,
      "! <p class="shorttext synchronized">List of JobScheduleStatus</p>
      tyt_job_schedule_status TYPE STANDARD TABLE OF tys_job_schedule_status WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobStatusInfo</p>
      BEGIN OF tys_job_status_info,
        "! <em>Key property</em> JobStatus
        job_status      TYPE c LENGTH 1,
        "! JobStatusText
        job_status_text TYPE c LENGTH 60,
      END OF tys_job_status_info,
      "! <p class="shorttext synchronized">List of JobStatusInfo</p>
      tyt_job_status_info TYPE STANDARD TABLE OF tys_job_status_info WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobStep</p>
      BEGIN OF tys_job_step,
        "! <em>Key property</em> JobName
        job_name               TYPE c LENGTH 32,
        "! <em>Key property</em> JobRunCount
        job_run_count          TYPE c LENGTH 8,
        "! <em>Key property</em> StepNumber
        step_number            TYPE int4,
        "! JobCatalogEntryName
        job_catalog_entry_name TYPE c LENGTH 40,
        "! JobCatalogEntryText
        job_catalog_entry_text TYPE c LENGTH 120,
        "! StepStartDateTime
        step_start_date_time   TYPE c LENGTH 20,
        "! StepStatus
        step_status            TYPE c LENGTH 1,
        "! StepAppRC
        step_app_rc            TYPE int4,
        "! StepHasResults
        step_has_results       TYPE abap_bool,
        "! NrOfLogs
        nr_of_logs             TYPE int4,
      END OF tys_job_step,
      "! <p class="shorttext synchronized">List of JobStep</p>
      tyt_job_step TYPE STANDARD TABLE OF tys_job_step WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobStepLogInfo</p>
      BEGIN OF tys_job_step_log_info,
        "! <em>Key property</em> JobName
        job_name       TYPE c LENGTH 32,
        "! <em>Key property</em> JobRunCount
        job_run_count  TYPE c LENGTH 8,
        "! <em>Key property</em> StepNumber
        step_number    TYPE int4,
        "! <em>Key property</em> LogHandle
        log_handle     TYPE c LENGTH 22,
        "! LogNumber
        log_number     TYPE c LENGTH 20,
        "! MsgCntAll
        msg_cnt_all    TYPE int4,
        "! MsgCntA
        msg_cnt_a      TYPE int4,
        "! MsgCntE
        msg_cnt_e      TYPE int4,
        "! MsgCntW
        msg_cnt_w      TYPE int4,
        "! MsgCntI
        msg_cnt_i      TYPE int4,
        "! MsgCntS
        msg_cnt_s      TYPE int4,
        "! CreaDateTime
        crea_date_time TYPE c LENGTH 20,
        "! CreaUser
        crea_user      TYPE c LENGTH 12,
        "! CreaUserLong
        crea_user_long TYPE string,
        "! Severity
        severity       TYPE c LENGTH 1,
        "! SeverityText
        severity_text  TYPE string,
      END OF tys_job_step_log_info,
      "! <p class="shorttext synchronized">List of JobStepLogInfo</p>
      tyt_job_step_log_info TYPE STANDARD TABLE OF tys_job_step_log_info WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobTemplate</p>
      BEGIN OF tys_job_template,
        "! JobReportName
        job_report_name            TYPE c LENGTH 40,
        "! <em>Key property</em> JobTemplateName
        job_template_name          TYPE c LENGTH 40,
        "! <em>Key property</em> JobTemplateVersion
        job_template_version       TYPE c LENGTH 1,
        "! JobUserName
        job_user_name              TYPE c LENGTH 12,
        "! JobCatalogEntryName
        job_catalog_entry_name     TYPE c LENGTH 40,
        "! SupportsTestMode
        supports_test_mode         TYPE abap_bool,
        "! JobTemplateText
        job_template_text          TYPE c LENGTH 120,
        "! CreationDateTime
        creation_date_time         TYPE timestampl,
        "! CreationUserName
        creation_user_name         TYPE c LENGTH 12,
        "! LastChangeDateTime
        last_change_date_time      TYPE timestampl,
        "! LastChangeUserName
        last_change_user_name      TYPE c LENGTH 12,
        "! JobPeriodicGranularity
        job_periodic_granularity   TYPE c LENGTH 2,
        "! JobPeriodicValue
        job_periodic_value         TYPE c LENGTH 3,
        "! JobTemplateLayerC
        job_template_layer_c       TYPE c LENGTH 1,
        "! JobTemplateHiddenInd
        job_template_hidden_ind    TYPE c LENGTH 1,
        "! JobCatalogEntryTypeC
        job_catalog_entry_type_c   TYPE c LENGTH 1,
        "! JobTemplateStepCount
        job_template_step_count    TYPE int4,
        "! JobTemplateSequence
        job_template_sequence      TYPE string,
        "! JobTemplateValues
        job_template_values        TYPE string,
        "! Text
        text                       TYPE c LENGTH 120,
        "! TextEn
        text_en                    TYPE c LENGTH 120,
        "! JobCatalogEntryText
        job_catalog_entry_text     TYPE c LENGTH 120,
        "! CreationFormattedName
        creation_formatted_name    TYPE c LENGTH 255,
        "! LastChangeFormattedName
        last_change_formatted_name TYPE c LENGTH 255,
      END OF tys_job_template,
      "! <p class="shorttext synchronized">List of JobTemplate</p>
      tyt_job_template TYPE STANDARD TABLE OF tys_job_template WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobTemplateParameter</p>
      BEGIN OF tys_job_template_parameter,
        "! BasicJobCatalogEntryName
        basic_job_catalog_entry_na TYPE c LENGTH 40,
        "! JobTempParamHasVhInd
        job_temp_param_has_vh_ind  TYPE c LENGTH 1,
        "! <em>Key property</em> JobTemplateName
        job_template_name          TYPE c LENGTH 40,
        "! JobTempParamReadOnlyInd
        job_temp_param_read_only_i TYPE c LENGTH 1,
        "! JobTemplateParamGroupName
        job_template_param_group_n TYPE c LENGTH 10,
        "! JobSequenceName
        job_sequence_name          TYPE c LENGTH 30,
        "! <em>Key property</em> JobTemplateVersion
        job_template_version       TYPE c LENGTH 1,
        "! <em>Key property</em> JobTemplateParameterName
        job_template_parameter_nam TYPE c LENGTH 38,
        "! JobTempParamHiddenInd
        job_temp_param_hidden_ind  TYPE c LENGTH 1,
        "! JobTempParamMandatoryInd
        job_temp_param_mandatory_i TYPE c LENGTH 1,
      END OF tys_job_template_parameter,
      "! <p class="shorttext synchronized">List of JobTemplateParameter</p>
      tyt_job_template_parameter TYPE STANDARD TABLE OF tys_job_template_parameter WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobTemplateParameterValueData</p>
      BEGIN OF tys_job_template_parameter_v_2,
        "! <em>Key property</em> JobTemplateName
        job_template_name          TYPE c LENGTH 40,
        "! <em>Key property</em> JobTemplateVersion
        job_template_version       TYPE c LENGTH 1,
        "! <em>Key property</em> JobTemplateParameterName
        job_template_parameter_nam TYPE c LENGTH 38,
        "! Uuid
        uuid                       TYPE c LENGTH 32,
        "! Sign
        sign                       TYPE c LENGTH 1,
        "! Opt
        opt                        TYPE c LENGTH 2,
        "! Low
        low                        TYPE c LENGTH 255,
        "! High
        high                       TYPE c LENGTH 255,
      END OF tys_job_template_parameter_v_2,
      "! <p class="shorttext synchronized">List of JobTemplateParameterValueData</p>
      tyt_job_template_parameter_v_2 TYPE STANDARD TABLE OF tys_job_template_parameter_v_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobTemplateParamGroup</p>
      BEGIN OF tys_job_template_param_group,
        "! JobSequenceName
        job_sequence_name          TYPE c LENGTH 30,
        "! <em>Key property</em> JobTemplateName
        job_template_name          TYPE c LENGTH 40,
        "! <em>Key property</em> JobTemplateVersion
        job_template_version       TYPE c LENGTH 1,
        "! <em>Key property</em> JobTemplateParamGroupName
        job_template_param_group_n TYPE c LENGTH 10,
        "! JobTemplateParamGroupText
        job_template_param_group_t TYPE c LENGTH 120,
        "! JobParameterSectionName
        job_parameter_section_name TYPE c LENGTH 10,
        "! BasicJobCatalogEntryName
        basic_job_catalog_entry_na TYPE c LENGTH 40,
        "! BasicJobTemplateGroupName
        basic_job_template_group_n TYPE c LENGTH 10,
      END OF tys_job_template_param_group,
      "! <p class="shorttext synchronized">List of JobTemplateParamGroup</p>
      tyt_job_template_param_group TYPE STANDARD TABLE OF tys_job_template_param_group WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobTemplateParamSection</p>
      BEGIN OF tys_job_template_param_secti_2,
        "! <em>Key property</em> JobTemplateName
        job_template_name          TYPE c LENGTH 40,
        "! <em>Key property</em> JobTemplateVersion
        job_template_version       TYPE c LENGTH 1,
        "! JobSequenceName
        job_sequence_name          TYPE c LENGTH 30,
        "! <em>Key property</em> JobParameterSectionName
        job_parameter_section_name TYPE c LENGTH 10,
        "! JobParameterSectionPosition
        job_parameter_section_posi TYPE int4,
        "! JobParameterSectionText
        job_parameter_section_text TYPE c LENGTH 120,
        "! BasicJobCatalogEntryName
        basic_job_catalog_entry_na TYPE c LENGTH 40,
      END OF tys_job_template_param_secti_2,
      "! <p class="shorttext synchronized">List of JobTemplateParamSection</p>
      tyt_job_template_param_secti_2 TYPE STANDARD TABLE OF tys_job_template_param_secti_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobTemplateParamValueData</p>
      BEGIN OF tys_job_template_param_value_2,
        "! <em>Key property</em> TemplateData
        template_data TYPE string,
      END OF tys_job_template_param_value_2,
      "! <p class="shorttext synchronized">List of JobTemplateParamValueData</p>
      tyt_job_template_param_value_2 TYPE STANDARD TABLE OF tys_job_template_param_value_2 WITH DEFAULT KEY.

    TYPES:
      "! <p class="shorttext synchronized">JobTemplateSequence</p>
      BEGIN OF tys_job_template_sequence,
        "! <em>Key property</em> JobTemplateName
        job_template_name          TYPE c LENGTH 40,
        "! <em>Key property</em> JobTemplateVersion
        job_template_version       TYPE c LENGTH 1,
        "! JceText
        jce_text                   TYPE c LENGTH 120,
        "! <em>Key property</em> JobSequenceName
        job_sequence_name          TYPE c LENGTH 30,
        "! JobSequencePosition
        job_sequence_position      TYPE int4,
        "! JobSequenceText
        job_sequence_text          TYPE c LENGTH 120,
        "! BasicJobCatalogEntryName
        basic_job_catalog_entry_na TYPE c LENGTH 40,
      END OF tys_job_template_sequence,
      "! <p class="shorttext synchronized">List of JobTemplateSequence</p>
      tyt_job_template_sequence TYPE STANDARD TABLE OF tys_job_template_sequence WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! ApplicationLogHeaderSet
        "! <br/> Collection of type 'ApplicationLogHeader'
        application_log_header_set TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'APPLICATION_LOG_HEADER_SET',
        "! ApplicationLogMeassageSet
        "! <br/> Collection of type 'ApplicationLogMessage'
        application_log_meassage_s TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'APPLICATION_LOG_MEASSAGE_S',
        "! FuncImpReturnCollection
        "! <br/> Collection of type 'FuncImpReturn'
        func_imp_return_collection TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'FUNC_IMP_RETURN_COLLECTION',
        "! JobinfoSet
        "! <br/> Collection of type 'Jobinfo'
        jobinfo_set                TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOBINFO_SET',
        "! JoblistSet
        "! <br/> Collection of type 'Joblist'
        joblist_set                TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOBLIST_SET',
        "! JobHeaderSet
        "! <br/> Collection of type 'JobHeader'
        job_header_set             TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_HEADER_SET',
        "! JobLogMessageSet
        "! <br/> Collection of type 'JobLogMessage'
        job_log_message_set        TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_LOG_MESSAGE_SET',
        "! JobLogSet
        "! <br/> Collection of type 'JobLog'
        job_log_set                TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_LOG_SET',
        "! JobParamValuesSet
        "! <br/> Collection of type 'JobParamValues'
        job_param_values_set       TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_PARAM_VALUES_SET',
        "! JobParamValuesStructSet
        "! <br/> Collection of type 'JobParamValuesStruct'
        job_param_values_struct_se TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_PARAM_VALUES_STRUCT_SE',
        "! JobScheduleCheckCollection
        "! <br/> Collection of type 'JobScheduleCheck'
        job_schedule_check_collect TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_SCHEDULE_CHECK_COLLECT',
        "! JobScheduleStatusCollection
        "! <br/> Collection of type 'JobScheduleStatus'
        job_schedule_status_collec TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_SCHEDULE_STATUS_COLLEC',
        "! JobStatusInfoSet
        "! <br/> Collection of type 'JobStatusInfo'
        job_status_info_set        TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_STATUS_INFO_SET',
        "! JobStepLogInfoSet
        "! <br/> Collection of type 'JobStepLogInfo'
        job_step_log_info_set      TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_STEP_LOG_INFO_SET',
        "! JobStepSet
        "! <br/> Collection of type 'JobStep'
        job_step_set               TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_STEP_SET',
        "! JobTemplateParameterSet
        "! <br/> Collection of type 'JobTemplateParameter'
        job_template_parameter_set TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_TEMPLATE_PARAMETER_SET',
        "! JobTemplateParameterValueDataSet
        "! <br/> Collection of type 'JobTemplateParameterValueData'
        job_template_parameter_val TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_TEMPLATE_PARAMETER_VAL',
        "! JobTemplateParamGroupSet
        "! <br/> Collection of type 'JobTemplateParamGroup'
        job_template_param_group_s TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_TEMPLATE_PARAM_GROUP_S',
        "! JobTemplateParamSectionSet
        "! <br/> Collection of type 'JobTemplateParamSection'
        job_template_param_section TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_TEMPLATE_PARAM_SECTION',
        "! JobTemplateParamValueDataSet
        "! <br/> Collection of type 'JobTemplateParamValueData'
        job_template_param_value_d TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_TEMPLATE_PARAM_VALUE_D',
        "! JobTemplateSequenceSet
        "! <br/> Collection of type 'JobTemplateSequence'
        job_template_sequence_set  TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_TEMPLATE_SEQUENCE_SET',
        "! JobTemplateSet
        "! <br/> Collection of type 'JobTemplate'
        job_template_set           TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'JOB_TEMPLATE_SET',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the function imports</p>
      BEGIN OF gcs_function_import,
        "! JobinfoGet
        "! <br/> See structure type {@link ..tys_parameters_1} for the parameters
        jobinfo_get                TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'JOBINFO_GET',
        "! JobAbort
        "! <br/> See structure type {@link ..tys_parameters_6} for the parameters
        job_abort                  TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'JOB_ABORT',
        "! JobCancel
        "! <br/> See structure type {@link ..tys_parameters_7} for the parameters
        job_cancel                 TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'JOB_CANCEL',
        "! JobListGet
        "! <br/> See structure type {@link ..tys_parameters_8} for the parameters
        job_list_get               TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'JOB_LIST_GET',
        "! JobParamValuesGet
        "! <br/> See structure type {@link ..tys_parameters_9} for the parameters
        job_param_values_get       TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'JOB_PARAM_VALUES_GET',
        "! JobParamValuesStructGet
        "! <br/> See structure type {@link ..tys_parameters_10} for the parameters
        job_param_values_struct_ge TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'JOB_PARAM_VALUES_STRUCT_GE',
        "! JobRestart
        "! <br/> See structure type {@link ..tys_parameters_11} for the parameters
        job_restart                TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'JOB_RESTART',
        "! JobSchedule
        "! <br/> See structure type {@link ..tys_parameters_12} for the parameters
        job_schedule               TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'JOB_SCHEDULE',
        "! JobScheduleCheck
        "! <br/> See structure type {@link ..tys_parameters_13} for the parameters
        job_schedule_check         TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'JOB_SCHEDULE_CHECK',
        "! JobStatusGet
        "! <br/> See structure type {@link ..tys_parameters_2} for the parameters
        job_status_get             TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'JOB_STATUS_GET',
        "! JobTemplateRead
        "! <br/> See structure type {@link ..tys_parameters_3} for the parameters
        job_template_read          TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'JOB_TEMPLATE_READ',
        "! TemplateValuesGet
        "! <br/> See structure type {@link ..tys_parameters_4} for the parameters
        template_values_get        TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'TEMPLATE_VALUES_GET',
        "! TemplateValuesStructGet
        "! <br/> See structure type {@link ..tys_parameters_5} for the parameters
        template_values_struct_get TYPE /iwbep/if_cp_runtime_types=>ty_operation_name VALUE 'TEMPLATE_VALUES_STRUCT_GET',
      END OF gcs_function_import.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal Names of the bound functions</p>
      BEGIN OF gcs_bound_function,
         "! Dummy field - Structure must not be empty
         dummy TYPE int1 VALUE 0,
      END OF gcs_bound_function.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for complex types</p>
      BEGIN OF gcs_complex_type,
         "! Dummy field - Structure must not be empty
         dummy TYPE int1 VALUE 0,
      END OF gcs_complex_type.

    CONSTANTS:
      "! <p class="shorttext synchronized">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
        "! <p class="shorttext synchronized">Internal names for ApplicationLogHeader</p>
        "! See also structure type {@link ..tys_application_log_header}
        BEGIN OF application_log_header,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! ApplicationLogMessageSet
            application_log_message_se TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'APPLICATION_LOG_MESSAGE_SE',
          END OF navigation,
        END OF application_log_header,
        "! <p class="shorttext synchronized">Internal names for ApplicationLogMessage</p>
        "! See also structure type {@link ..tys_application_log_message}
        BEGIN OF application_log_message,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF application_log_message,
        "! <p class="shorttext synchronized">Internal names for FuncImpReturn</p>
        "! See also structure type {@link ..tys_func_imp_return}
        BEGIN OF func_imp_return,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF func_imp_return,
        "! <p class="shorttext synchronized">Internal names for Jobinfo</p>
        "! See also structure type {@link ..tys_jobinfo}
        BEGIN OF jobinfo,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF jobinfo,
        "! <p class="shorttext synchronized">Internal names for Joblist</p>
        "! See also structure type {@link ..tys_joblist}
        BEGIN OF joblist,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF joblist,
        "! <p class="shorttext synchronized">Internal names for JobHeader</p>
        "! See also structure type {@link ..tys_job_header}
        BEGIN OF job_header,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! JobStepSet
            job_step_set TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_STEP_SET',
          END OF navigation,
        END OF job_header,
        "! <p class="shorttext synchronized">Internal names for JobLog</p>
        "! See also structure type {@link ..tys_job_log}
        BEGIN OF job_log,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! ApplicationLogHeaderSet
            application_log_header_set TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'APPLICATION_LOG_HEADER_SET',
          END OF navigation,
        END OF job_log,
        "! <p class="shorttext synchronized">Internal names for JobLogMessage</p>
        "! See also structure type {@link ..tys_job_log_message}
        BEGIN OF job_log_message,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF job_log_message,
        "! <p class="shorttext synchronized">Internal names for JobParamValues</p>
        "! See also structure type {@link ..tys_job_param_values}
        BEGIN OF job_param_values,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF job_param_values,
        "! <p class="shorttext synchronized">Internal names for JobParamValuesStruct</p>
        "! See also structure type {@link ..tys_job_param_values_struct}
        BEGIN OF job_param_values_struct,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF job_param_values_struct,
        "! <p class="shorttext synchronized">Internal names for JobScheduleCheck</p>
        "! See also structure type {@link ..tys_job_schedule_check_3}
        BEGIN OF job_schedule_check_3,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF job_schedule_check_3,
        "! <p class="shorttext synchronized">Internal names for JobScheduleStatus</p>
        "! See also structure type {@link ..tys_job_schedule_status}
        BEGIN OF job_schedule_status,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF job_schedule_status,
        "! <p class="shorttext synchronized">Internal names for JobStatusInfo</p>
        "! See also structure type {@link ..tys_job_status_info}
        BEGIN OF job_status_info,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF job_status_info,
        "! <p class="shorttext synchronized">Internal names for JobStep</p>
        "! See also structure type {@link ..tys_job_step}
        BEGIN OF job_step,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! JobStepLogInfoSet
            job_step_log_info_set TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_STEP_LOG_INFO_SET',
          END OF navigation,
        END OF job_step,
        "! <p class="shorttext synchronized">Internal names for JobStepLogInfo</p>
        "! See also structure type {@link ..tys_job_step_log_info}
        BEGIN OF job_step_log_info,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! JobLogMessageSet
            job_log_message_set TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_LOG_MESSAGE_SET',
          END OF navigation,
        END OF job_step_log_info,
        "! <p class="shorttext synchronized">Internal names for JobTemplate</p>
        "! See also structure type {@link ..tys_job_template}
        BEGIN OF job_template,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! JobTemplateParameterSet
            job_template_parameter_set TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_TEMPLATE_PARAMETER_SET',
            "! JobTemplateParamGroupSet
            job_template_param_group_s TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_TEMPLATE_PARAM_GROUP_S',
            "! JobTemplateParamSectionSet
            job_template_param_section TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_TEMPLATE_PARAM_SECTION',
            "! JobTemplateSequenceSet
            job_template_sequence_set  TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_TEMPLATE_SEQUENCE_SET',
          END OF navigation,
        END OF job_template,
        "! <p class="shorttext synchronized">Internal names for JobTemplateParameter</p>
        "! See also structure type {@link ..tys_job_template_parameter}
        BEGIN OF job_template_parameter,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! JobTemplateParameterValueDataSet
            job_template_parameter_val TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_TEMPLATE_PARAMETER_VAL',
          END OF navigation,
        END OF job_template_parameter,
        "! <p class="shorttext synchronized">Internal names for JobTemplateParameterValueData</p>
        "! See also structure type {@link ..tys_job_template_parameter_v_2}
        BEGIN OF job_template_parameter_v_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF job_template_parameter_v_2,
        "! <p class="shorttext synchronized">Internal names for JobTemplateParamGroup</p>
        "! See also structure type {@link ..tys_job_template_param_group}
        BEGIN OF job_template_param_group,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! JobTemplateParameterSet
            job_template_parameter_set TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_TEMPLATE_PARAMETER_SET',
          END OF navigation,
        END OF job_template_param_group,
        "! <p class="shorttext synchronized">Internal names for JobTemplateParamSection</p>
        "! See also structure type {@link ..tys_job_template_param_secti_2}
        BEGIN OF job_template_param_secti_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! JobTemplateParamGroupSet
            job_template_param_group_s TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_TEMPLATE_PARAM_GROUP_S',
          END OF navigation,
        END OF job_template_param_secti_2,
        "! <p class="shorttext synchronized">Internal names for JobTemplateParamValueData</p>
        "! See also structure type {@link ..tys_job_template_param_value_2}
        BEGIN OF job_template_param_value_2,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! Dummy field - Structure must not be empty
            dummy TYPE int1 VALUE 0,
          END OF navigation,
        END OF job_template_param_value_2,
        "! <p class="shorttext synchronized">Internal names for JobTemplateSequence</p>
        "! See also structure type {@link ..tys_job_template_sequence}
        BEGIN OF job_template_sequence,
          "! <p class="shorttext synchronized">Navigation properties</p>
          BEGIN OF navigation,
            "! JobTemplateParameterSet
            job_template_parameter_set TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_TEMPLATE_PARAMETER_SET',
            "! JobTemplateParamSectionSet
            job_template_param_section TYPE /iwbep/if_v4_pm_types=>ty_internal_name VALUE 'JOB_TEMPLATE_PARAM_SECTION',
          END OF navigation,
        END OF job_template_sequence,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.


  PRIVATE SECTION.

    "! <p class="shorttext synchronized">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized">Define ApplicationLogHeader</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_application_log_header RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define ApplicationLogMessage</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_application_log_message RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define FuncImpReturn</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_func_imp_return RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define Jobinfo</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_jobinfo RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define Joblist</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_joblist RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobHeader</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_header RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobLog</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_log RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobLogMessage</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_log_message RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobParamValues</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_param_values RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobParamValuesStruct</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_param_values_struct RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobScheduleCheck</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_schedule_check_3 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobScheduleStatus</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_schedule_status RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobStatusInfo</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_status_info RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobStep</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_step RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobStepLogInfo</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_step_log_info RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobTemplate</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_template RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobTemplateParameter</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_template_parameter RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobTemplateParameterValueData</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_template_parameter_v_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobTemplateParamGroup</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_template_param_group RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobTemplateParamSection</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_template_param_secti_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobTemplateParamValueData</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_template_param_value_2 RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobTemplateSequence</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_template_sequence RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobinfoGet</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_jobinfo_get RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobAbort</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_abort RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobCancel</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_cancel RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobListGet</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_list_get RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobParamValuesGet</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_param_values_get RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobParamValuesStructGet</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_param_values_struct_ge RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobRestart</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_restart RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobSchedule</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_schedule RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobScheduleCheck</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_schedule_check RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobStatusGet</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_status_get RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define JobTemplateRead</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_job_template_read RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define TemplateValuesGet</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_template_values_get RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define TemplateValuesStructGet</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS def_template_values_struct_get RAISING /iwbep/cx_gateway.

    "! <p class="shorttext synchronized">Define all primitive types</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized">Gateway Exception</p>
    METHODS define_primitive_types RAISING /iwbep/cx_gateway.

ENDCLASS.



CLASS ZSC_OD_SAP_COM_0326 IMPLEMENTATION.


  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'BC_EXT_APPJOB_MANAGEMENT' ) ##NO_TEXT.

    def_application_log_header( ).
    def_application_log_message( ).
    def_func_imp_return( ).
    def_jobinfo( ).
    def_joblist( ).
    def_job_header( ).
    def_job_log( ).
    def_job_log_message( ).
    def_job_param_values( ).
    def_job_param_values_struct( ).
    def_job_schedule_check_3( ).
    def_job_schedule_status( ).
    def_job_status_info( ).
    def_job_step( ).
    def_job_step_log_info( ).
    def_job_template( ).
    def_job_template_parameter( ).
    def_job_template_parameter_v_2( ).
    def_job_template_param_group( ).
    def_job_template_param_secti_2( ).
    def_job_template_param_value_2( ).
    def_job_template_sequence( ).
    def_jobinfo_get( ).
    def_job_abort( ).
    def_job_cancel( ).
    def_job_list_get( ).
    def_job_param_values_get( ).
    def_job_param_values_struct_ge( ).
    def_job_restart( ).
    def_job_schedule( ).
    def_job_schedule_check( ).
    def_job_status_get( ).
    def_job_template_read( ).
    def_template_values_get( ).
    def_template_values_struct_get( ).
    define_primitive_types( ).

  ENDMETHOD.


  METHOD define_primitive_types.

    DATA lo_primitive_type TYPE REF TO /iwbep/if_v4_pm_prim_type.


    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'CREATION_TIME_FROM'
                            iv_element             = VALUE tys_types_for_prim_types-creation_time_from( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'CREATION_TIME_TO'
                            iv_element             = VALUE tys_types_for_prim_types-creation_time_to( ) ).
    lo_primitive_type->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_type->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_COUNT'
                            iv_element             = VALUE tys_types_for_prim_types-job_count( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_COUNT_2'
                            iv_element             = VALUE tys_types_for_prim_types-job_count_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_CREATOR'
                            iv_element             = VALUE tys_types_for_prim_types-job_creator( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_NAME'
                            iv_element             = VALUE tys_types_for_prim_types-job_name( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_NAME_2'
                            iv_element             = VALUE tys_types_for_prim_types-job_name_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_NAME_3'
                            iv_element             = VALUE tys_types_for_prim_types-job_name_3( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_NAME_4'
                            iv_element             = VALUE tys_types_for_prim_types-job_name_4( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_NAME_5'
                            iv_element             = VALUE tys_types_for_prim_types-job_name_5( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_NAME_6'
                            iv_element             = VALUE tys_types_for_prim_types-job_name_6( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_NAME_7'
                            iv_element             = VALUE tys_types_for_prim_types-job_name_7( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_NAME_8'
                            iv_element             = VALUE tys_types_for_prim_types-job_name_8( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_PARAMETER_VALUES'
                            iv_element             = VALUE tys_types_for_prim_types-job_parameter_values( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_PARAMETER_VALUES_2'
                            iv_element             = VALUE tys_types_for_prim_types-job_parameter_values_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_PARAMETER_VALUES_SIMPL'
                            iv_element             = VALUE tys_types_for_prim_types-job_parameter_values_simpl( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_PARAMETER_VALUES_SIM_2'
                            iv_element             = VALUE tys_types_for_prim_types-job_parameter_values_sim_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_RESTART_MODE'
                            iv_element             = VALUE tys_types_for_prim_types-job_restart_mode( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_RUN_COUNT'
                            iv_element             = VALUE tys_types_for_prim_types-job_run_count( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_RUN_COUNT_2'
                            iv_element             = VALUE tys_types_for_prim_types-job_run_count_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_RUN_COUNT_3'
                            iv_element             = VALUE tys_types_for_prim_types-job_run_count_3( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_RUN_COUNT_4'
                            iv_element             = VALUE tys_types_for_prim_types-job_run_count_4( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_RUN_COUNT_5'
                            iv_element             = VALUE tys_types_for_prim_types-job_run_count_5( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_TEMPLATE_NAME'
                            iv_element             = VALUE tys_types_for_prim_types-job_template_name( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_TEMPLATE_NAME_2'
                            iv_element             = VALUE tys_types_for_prim_types-job_template_name_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_TEMPLATE_NAME_3'
                            iv_element             = VALUE tys_types_for_prim_types-job_template_name_3( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_TEMPLATE_NAME_4'
                            iv_element             = VALUE tys_types_for_prim_types-job_template_name_4( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_TEMPLATE_NAME_5'
                            iv_element             = VALUE tys_types_for_prim_types-job_template_name_5( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_TEXT'
                            iv_element             = VALUE tys_types_for_prim_types-job_text( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_TEXT_2'
                            iv_element             = VALUE tys_types_for_prim_types-job_text_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_USER'
                            iv_element             = VALUE tys_types_for_prim_types-job_user( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_USER_2'
                            iv_element             = VALUE tys_types_for_prim_types-job_user_2( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_USER_ID'
                            iv_element             = VALUE tys_types_for_prim_types-job_user_id( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'JOB_USER_NAME'
                            iv_element             = VALUE tys_types_for_prim_types-job_user_name( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'REPORT'
                            iv_element             = VALUE tys_types_for_prim_types-report( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'TEMPLATE_NAME'
                            iv_element             = VALUE tys_types_for_prim_types-template_name( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'TEST_MODE_IND'
                            iv_element             = VALUE tys_types_for_prim_types-test_mode_ind( ) ).
    lo_primitive_type->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

    lo_primitive_type = mo_model->create_primitive_type_by_elem(
                            iv_primitive_type_name = 'VARIANT'
                            iv_element             = VALUE tys_types_for_prim_types-variant( ) ).
    lo_primitive_type->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_type->set_scale_variable( ).

  ENDMETHOD.


  METHOD def_application_log_header.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'APPLICATION_LOG_HEADER'
                                    is_structure              = VALUE tys_application_log_header( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'ApplicationLogHeader' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'APPLICATION_LOG_HEADER_SET' ).
    lo_entity_set->set_edm_name( 'ApplicationLogHeaderSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_NAME' ).
    lo_primitive_property->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 32 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SEVERITY_TEXT' ).
    lo_primitive_property->set_edm_name( 'SeverityText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 100 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TEXT' ).
    lo_primitive_property->set_edm_name( 'Text' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SUB_OBJECT_TEXT' ).
    lo_primitive_property->set_edm_name( 'SubObjectText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 60 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SUB_OBJECT' ).
    lo_primitive_property->set_edm_name( 'SubObject' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SEVERITY' ).
    lo_primitive_property->set_edm_name( 'Severity' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'OBJECT_TEXT' ).
    lo_primitive_property->set_edm_name( 'ObjectText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 60 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'OBJECT' ).
    lo_primitive_property->set_edm_name( 'Object' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_CONTEXT_FIELD_5_TY' ).
    lo_primitive_property->set_edm_name( 'MessageContextField5Type' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_CONTEXT_FIELD_4_TY' ).
    lo_primitive_property->set_edm_name( 'MessageContextField4Type' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_CONTEXT_FIELD_3_TY' ).
    lo_primitive_property->set_edm_name( 'MessageContextField3Type' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_CONTEXT_FIELD_2_TY' ).
    lo_primitive_property->set_edm_name( 'MessageContextField2Type' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_CONTEXT_FIELD_1_TY' ).
    lo_primitive_property->set_edm_name( 'MessageContextField1Type' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_TOTAL_COUNT' ).
    lo_primitive_property->set_edm_name( 'MessageTotalCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_COUNT_W' ).
    lo_primitive_property->set_edm_name( 'MessageCountW' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_COUNT_S' ).
    lo_primitive_property->set_edm_name( 'MessageCountS' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_COUNT_I' ).
    lo_primitive_property->set_edm_name( 'MessageCountI' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_COUNT_E' ).
    lo_primitive_property->set_edm_name( 'MessageCountE' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_COUNT_A' ).
    lo_primitive_property->set_edm_name( 'MessageCountA' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_CONTEXT_FIELD_5_LA' ).
    lo_primitive_property->set_edm_name( 'MessageContextField5Label' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_CONTEXT_FIELD_4_LA' ).
    lo_primitive_property->set_edm_name( 'MessageContextField4Label' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_CONTEXT_FIELD_3_LA' ).
    lo_primitive_property->set_edm_name( 'MessageContextField3Label' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_CONTEXT_FIELD_2_LA' ).
    lo_primitive_property->set_edm_name( 'MessageContextField2Label' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_CONTEXT_FIELD_1_LA' ).
    lo_primitive_property->set_edm_name( 'MessageContextField1Label' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LOG_NUMBER' ).
    lo_primitive_property->set_edm_name( 'LogNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LOG_HANDLE' ).
    lo_primitive_property->set_edm_name( 'LogHandle' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 22 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LAST_CHANGED_USER' ).
    lo_primitive_property->set_edm_name( 'LastChangedUser' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LAST_CHANGED_TIME' ).
    lo_primitive_property->set_edm_name( 'LastChangedTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'TimeOfDay' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'Time' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LAST_CHANGED_DATE' ).
    lo_primitive_property->set_edm_name( 'LastChangedDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 7 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HAS_MESSAGE_CONTEXT_FIELD' ).
    lo_primitive_property->set_edm_name( 'HasMessageContextField5' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HAS_MESSAGE_CONTEXT_FIEL_2' ).
    lo_primitive_property->set_edm_name( 'HasMessageContextField4' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HAS_MESSAGE_CONTEXT_FIEL_3' ).
    lo_primitive_property->set_edm_name( 'HasMessageContextField3' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HAS_MESSAGE_CONTEXT_FIEL_4' ).
    lo_primitive_property->set_edm_name( 'HasMessageContextField2' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HAS_MESSAGE_CONTEXT_FIEL_5' ).
    lo_primitive_property->set_edm_name( 'HasMessageContextField1' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'EXTERNAL_NUMBER' ).
    lo_primitive_property->set_edm_name( 'ExternalNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 100 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'EXPIRATION_DATE' ).
    lo_primitive_property->set_edm_name( 'ExpirationDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 7 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREATED_BY_USER' ).
    lo_primitive_property->set_edm_name( 'CreatedByUser' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREATED_BY_FORMATTED_NAME' ).
    lo_primitive_property->set_edm_name( 'CreatedByFormattedName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 255 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREATED_AT_TIME' ).
    lo_primitive_property->set_edm_name( 'CreatedAtTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'TimeOfDay' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'Time' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREATED_AT_DATE' ).
    lo_primitive_property->set_edm_name( 'CreatedAtDate' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 7 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREATED_AT' ).
    lo_primitive_property->set_edm_name( 'CreatedAt' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_navigation_property = lo_entity_type->create_navigation_property( 'APPLICATION_LOG_MESSAGE_SE' ).
    lo_navigation_property->set_edm_name( 'ApplicationLogMessageSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'APPLICATION_LOG_MESSAGE' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.


  METHOD def_application_log_message.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'APPLICATION_LOG_MESSAGE'
                                    is_structure              = VALUE tys_application_log_message( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'ApplicationLogMessage' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'APPLICATION_LOG_MEASSAGE_S' ).
    lo_entity_set->set_edm_name( 'ApplicationLogMeassageSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'CONTEXT_FIELD_1' ).
    lo_primitive_property->set_edm_name( 'ContextField1' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 256 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FILTER_FIELD_NAME' ).
    lo_primitive_property->set_edm_name( 'FilterFieldName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FILTER_FIELD_VALUE' ).
    lo_primitive_property->set_edm_name( 'FilterFieldValue' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 100 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TYPE_TEXT' ).
    lo_primitive_property->set_edm_name( 'TypeText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DETAIL_LEVEL' ).
    lo_primitive_property->set_edm_name( 'DetailLevel' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CONTEXT_FIELD_2' ).
    lo_primitive_property->set_edm_name( 'ContextField2' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 256 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CONTEXT_FIELD_3' ).
    lo_primitive_property->set_edm_name( 'ContextField3' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 256 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HAS_DETAIL_TEXT' ).
    lo_primitive_property->set_edm_name( 'HasDetailText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CONTEXT_FIELD_4' ).
    lo_primitive_property->set_edm_name( 'ContextField4' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 256 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CONTEXT_FIELD_5' ).
    lo_primitive_property->set_edm_name( 'ContextField5' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 256 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LOG_HANDLE' ).
    lo_primitive_property->set_edm_name( 'LogHandle' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 22 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MESSAGE_NUMBER' ).
    lo_primitive_property->set_edm_name( 'MessageNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TIMESTAMP' ).
    lo_primitive_property->set_edm_name( 'Timestamp' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 7 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TYPE' ).
    lo_primitive_property->set_edm_name( 'Type' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TEXT' ).
    lo_primitive_property->set_edm_name( 'Text' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HAS_LONG_TEXT' ).
    lo_primitive_property->set_edm_name( 'HasLongText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

  ENDMETHOD.


  METHOD def_func_imp_return.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'FUNC_IMP_RETURN'
                                    is_structure              = VALUE tys_func_imp_return( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'FuncImpReturn' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'FUNC_IMP_RETURN_COLLECTION' ).
    lo_entity_set->set_edm_name( 'FuncImpReturnCollection' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'RETURN_CODE' ).
    lo_primitive_property->set_edm_name( 'ReturnCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int16' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

  ENDMETHOD.


  METHOD def_jobinfo.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOBINFO'
                                    is_structure              = VALUE tys_jobinfo( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'Jobinfo' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOBINFO_SET' ).
    lo_entity_set->set_edm_name( 'JobinfoSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_NAME' ).
    lo_primitive_property->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 32 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_RUN_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_STATUS' ).
    lo_primitive_property->set_edm_name( 'JobStatus' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_SDL_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'JobSdlDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_START_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'JobStartDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_END_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'JobEndDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_APP_RC' ).
    lo_primitive_property->set_edm_name( 'JobAppRC' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_COUNT' ).
    lo_primitive_property->set_edm_name( 'StepCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_STATUS' ).
    lo_primitive_property->set_edm_name( 'StepStatus' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_START_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'StepStartDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_APP_RC' ).
    lo_primitive_property->set_edm_name( 'StepAppRC' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

  ENDMETHOD.


  METHOD def_jobinfo_get.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'JOBINFO_GET' ).
    lo_function->set_edm_name( 'JobinfoGet' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_1( ) ).

    lo_function_import = lo_function->create_function_import( 'JOBINFO_GET' ).
    lo_function_import->set_edm_name( 'JobinfoGet' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'GET' ).


    lo_parameter = lo_function->create_parameter( 'JOB_NAME' ).
    lo_parameter->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_NAME' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_RUN_COUNT' ).
    lo_parameter->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_RUN_COUNT' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'JOBINFO' ).
    lo_return->set_is_collection( ).

  ENDMETHOD.


  METHOD def_joblist.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOBLIST'
                                    is_structure              = VALUE tys_joblist( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'Joblist' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOBLIST_SET' ).
    lo_entity_set->set_edm_name( 'JoblistSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_NAME' ).
    lo_primitive_property->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 32 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_RUN_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEXT' ).
    lo_primitive_property->set_edm_name( 'JobText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TEMPLATE_NAME' ).
    lo_primitive_property->set_edm_name( 'TemplateName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_CREATOR' ).
    lo_primitive_property->set_edm_name( 'JobCreator' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'REPORT' ).
    lo_primitive_property->set_edm_name( 'Report' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'VARIANT' ).
    lo_primitive_property->set_edm_name( 'Variant' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 14 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'NR_STEPS' ).
    lo_primitive_property->set_edm_name( 'NrSteps' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_STATUS' ).
    lo_primitive_property->set_edm_name( 'JobStatus' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_LOG_STATUS' ).
    lo_primitive_property->set_edm_name( 'JobLogStatus' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_CREA_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'JobCreaDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_SCHED_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'JobSchedDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_START_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'JobStartDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_END_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'JobEndDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_APP_RC' ).
    lo_primitive_property->set_edm_name( 'JobAppRC' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_STATUS' ).
    lo_primitive_property->set_edm_name( 'StepStatus' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_START_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'StepStartDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_AP_RC' ).
    lo_primitive_property->set_edm_name( 'StepApRC' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

  ENDMETHOD.


  METHOD def_job_abort.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'JOB_ABORT' ).
    lo_function->set_edm_name( 'JobAbort' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_6( ) ).

    lo_function_import = lo_function->create_function_import( 'JOB_ABORT' ).
    lo_function_import->set_edm_name( 'JobAbort' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'POST' ).


    lo_parameter = lo_function->create_parameter( 'JOB_RUN_COUNT' ).
    lo_parameter->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_RUN_COUNT_3' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_NAME' ).
    lo_parameter->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_NAME_4' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'FUNC_IMP_RETURN' ).

  ENDMETHOD.


  METHOD def_job_cancel.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'JOB_CANCEL' ).
    lo_function->set_edm_name( 'JobCancel' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_7( ) ).

    lo_function_import = lo_function->create_function_import( 'JOB_CANCEL' ).
    lo_function_import->set_edm_name( 'JobCancel' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'POST' ).


    lo_parameter = lo_function->create_parameter( 'JOB_RUN_COUNT' ).
    lo_parameter->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_RUN_COUNT_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_NAME' ).
    lo_parameter->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_NAME_3' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'FUNC_IMP_RETURN' ).

  ENDMETHOD.


  METHOD def_job_header.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_HEADER'
                                    is_structure              = VALUE tys_job_header( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobHeader' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_HEADER_SET' ).
    lo_entity_set->set_edm_name( 'JobHeaderSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_NAME' ).
    lo_primitive_property->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 32 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_RUN_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEXT' ).
    lo_primitive_property->set_edm_name( 'JobText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_TEXT' ).
    lo_primitive_property->set_edm_name( 'JobTemplateText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_SERIES_CREATED_AT' ).
    lo_primitive_property->set_edm_name( 'JobSeriesCreatedAt' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_CREATED_BY' ).
    lo_primitive_property->set_edm_name( 'JobCreatedBy' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_STATUS' ).
    lo_primitive_property->set_edm_name( 'JobStatus' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_PLANNED_START_DATE_TIM' ).
    lo_primitive_property->set_edm_name( 'JobPlannedStartDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_CREA_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'JobCreaDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_START_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'JobStartDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_END_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'JobEndDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PERIODIC' ).
    lo_primitive_property->set_edm_name( 'Periodic' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PERIODIC_MINUTES' ).
    lo_primitive_property->set_edm_name( 'PeriodicMinutes' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PERIODIC_HOURS' ).
    lo_primitive_property->set_edm_name( 'PeriodicHours' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PERIODIC_DAYS' ).
    lo_primitive_property->set_edm_name( 'PeriodicDays' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PERIODIC_WEEKS' ).
    lo_primitive_property->set_edm_name( 'PeriodicWeeks' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PERIODIC_MONTHS' ).
    lo_primitive_property->set_edm_name( 'PeriodicMonths' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_STEP_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobStepCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_CREATED_BY_FORMATTED_N' ).
    lo_primitive_property->set_edm_name( 'JobCreatedByFormattedName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 80 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_END_MAX_ITERATIONS' ).
    lo_primitive_property->set_edm_name( 'JobEndMaxIterations' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TASK_END_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'TaskEndDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'FACTORY_CALENDAR' ).
    lo_primitive_property->set_edm_name( 'FactoryCalendar' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'START_RESTRICTION_CODE' ).
    lo_primitive_property->set_edm_name( 'StartRestrictionCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TASK_WEEK_DAY' ).
    lo_primitive_property->set_edm_name( 'TaskWeekDay' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 7 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TASK_WORK_DAY_NO' ).
    lo_primitive_property->set_edm_name( 'TaskWorkDayNo' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TASK_WORK_DIR_CDIR' ).
    lo_primitive_property->set_edm_name( 'TaskWorkDirCdir' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TASK_USE_WORKDAYS_IND' ).
    lo_primitive_property->set_edm_name( 'TaskUseWorkdaysInd' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TIME_ZONE' ).
    lo_primitive_property->set_edm_name( 'TimeZone' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_HAS_RESULTS' ).
    lo_primitive_property->set_edm_name( 'JobHasResults' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ORIG_JOB_NAME' ).
    lo_primitive_property->set_edm_name( 'OrigJobName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 32 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ORIG_JOB_COUNT' ).
    lo_primitive_property->set_edm_name( 'OrigJobCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_RESTART_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobRestartCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_RUN_RESTART_MODE' ).
    lo_primitive_property->set_edm_name( 'JobRunRestartMode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_STEP_SET' ).
    lo_navigation_property->set_edm_name( 'JobStepSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_STEP' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.


  METHOD def_job_list_get.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'JOB_LIST_GET' ).
    lo_function->set_edm_name( 'JobListGet' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_8( ) ).

    lo_function_import = lo_function->create_function_import( 'JOB_LIST_GET' ).
    lo_function_import->set_edm_name( 'JobListGet' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'GET' ).


    lo_parameter = lo_function->create_parameter( 'JOB_TEXT' ).
    lo_parameter->set_edm_name( 'JobText' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_TEXT' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'CREATION_TIME_FROM' ).
    lo_parameter->set_edm_name( 'CreationTimeFrom' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'CREATION_TIME_FROM' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'CREATION_TIME_TO' ).
    lo_parameter->set_edm_name( 'CreationTimeTo' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'CREATION_TIME_TO' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'TEMPLATE_NAME' ).
    lo_parameter->set_edm_name( 'TemplateName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'TEMPLATE_NAME' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_CREATOR' ).
    lo_parameter->set_edm_name( 'JobCreator' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_CREATOR' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'REPORT' ).
    lo_parameter->set_edm_name( 'Report' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'REPORT' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'VARIANT' ).
    lo_parameter->set_edm_name( 'Variant' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'VARIANT' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_NAME' ).
    lo_parameter->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_NAME_2' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'JOBLIST' ).
    lo_return->set_is_collection( ).

  ENDMETHOD.


  METHOD def_job_log.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_LOG'
                                    is_structure              = VALUE tys_job_log( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobLog' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_LOG_SET' ).
    lo_entity_set->set_edm_name( 'JobLogSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_NAME' ).
    lo_primitive_property->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 32 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 14 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_NUMBER' ).
    lo_primitive_property->set_edm_name( 'StepNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LOG_HANDLE' ).
    lo_primitive_property->set_edm_name( 'LogHandle' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 22 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'APPLICATION_LOG_HEADER_SET' ).
    lo_navigation_property->set_edm_name( 'ApplicationLogHeaderSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'APPLICATION_LOG_HEADER' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.


  METHOD def_job_log_message.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_LOG_MESSAGE'
                                    is_structure              = VALUE tys_job_log_message( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobLogMessage' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_LOG_MESSAGE_SET' ).
    lo_entity_set->set_edm_name( 'JobLogMessageSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_NAME' ).
    lo_primitive_property->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 32 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_RUN_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_NUMBER' ).
    lo_primitive_property->set_edm_name( 'StepNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LOG_HANDLE' ).
    lo_primitive_property->set_edm_name( 'LogHandle' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 22 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_NUMBER' ).
    lo_primitive_property->set_edm_name( 'MsgNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_TYPE' ).
    lo_primitive_property->set_edm_name( 'MsgType' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_ID' ).
    lo_primitive_property->set_edm_name( 'MsgId' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_NO' ).
    lo_primitive_property->set_edm_name( 'MsgNo' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_V_1' ).
    lo_primitive_property->set_edm_name( 'MsgV1' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_V_2' ).
    lo_primitive_property->set_edm_name( 'MsgV2' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 50 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_V_3' ).
    lo_primitive_property->set_edm_name( 'MsgV3' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 50 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_V_4' ).
    lo_primitive_property->set_edm_name( 'MsgV4' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 50 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_TEXT' ).
    lo_primitive_property->set_edm_name( 'MsgText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

  ENDMETHOD.


  METHOD def_job_param_values.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_PARAM_VALUES'
                                    is_structure              = VALUE tys_job_param_values( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobParamValues' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_PARAM_VALUES_SET' ).
    lo_entity_set->set_edm_name( 'JobParamValuesSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'PARAMETER_VALUES' ).
    lo_primitive_property->set_edm_name( 'ParameterValues' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

  ENDMETHOD.


  METHOD def_job_param_values_get.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'JOB_PARAM_VALUES_GET' ).
    lo_function->set_edm_name( 'JobParamValuesGet' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_9( ) ).

    lo_function_import = lo_function->create_function_import( 'JOB_PARAM_VALUES_GET' ).
    lo_function_import->set_edm_name( 'JobParamValuesGet' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'GET' ).


    lo_parameter = lo_function->create_parameter( 'JOB_NAME' ).
    lo_parameter->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_NAME_7' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_COUNT' ).
    lo_parameter->set_edm_name( 'JobCount' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_COUNT' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'JOB_PARAM_VALUES' ).

  ENDMETHOD.


  METHOD def_job_param_values_struct.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_PARAM_VALUES_STRUCT'
                                    is_structure              = VALUE tys_job_param_values_struct( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobParamValuesStruct' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_PARAM_VALUES_STRUCT_SE' ).
    lo_entity_set->set_edm_name( 'JobParamValuesStructSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_NR' ).
    lo_primitive_property->set_edm_name( 'StepNr' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_PARAMETER_NAME' ).
    lo_primitive_property->set_edm_name( 'JobParameterName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 38 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SIGN' ).
    lo_primitive_property->set_edm_name( 'Sign' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'OPTION' ).
    lo_primitive_property->set_edm_name( 'Option' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LOW' ).
    lo_primitive_property->set_edm_name( 'Low' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 255 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HIGH' ).
    lo_primitive_property->set_edm_name( 'High' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 255 ) ##NUMBER_OK.

  ENDMETHOD.


  METHOD def_job_param_values_struct_ge.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'JOB_PARAM_VALUES_STRUCT_GE' ).
    lo_function->set_edm_name( 'JobParamValuesStructGet' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_10( ) ).

    lo_function_import = lo_function->create_function_import( 'JOB_PARAM_VALUES_STRUCT_GE' ).
    lo_function_import->set_edm_name( 'JobParamValuesStructGet' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'GET' ).


    lo_parameter = lo_function->create_parameter( 'JOB_NAME' ).
    lo_parameter->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_NAME_8' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_COUNT' ).
    lo_parameter->set_edm_name( 'JobCount' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_COUNT_2' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'JOB_PARAM_VALUES_STRUCT' ).
    lo_return->set_is_collection( ).

  ENDMETHOD.


  METHOD def_job_restart.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'JOB_RESTART' ).
    lo_function->set_edm_name( 'JobRestart' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_11( ) ).

    lo_function_import = lo_function->create_function_import( 'JOB_RESTART' ).
    lo_function_import->set_edm_name( 'JobRestart' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'POST' ).


    lo_parameter = lo_function->create_parameter( 'JOB_NAME' ).
    lo_parameter->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_NAME_6' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_RUN_COUNT' ).
    lo_parameter->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_RUN_COUNT_5' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_RESTART_MODE' ).
    lo_parameter->set_edm_name( 'JobRestartMode' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_RESTART_MODE' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'JOB_SCHEDULE_STATUS' ).

  ENDMETHOD.


  METHOD def_job_schedule.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'JOB_SCHEDULE' ).
    lo_function->set_edm_name( 'JobSchedule' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_12( ) ).

    lo_function_import = lo_function->create_function_import( 'JOB_SCHEDULE' ).
    lo_function_import->set_edm_name( 'JobSchedule' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'POST' ).


    lo_parameter = lo_function->create_parameter( 'JOB_USER_ID' ).
    lo_parameter->set_edm_name( 'JobUserID' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_USER_ID' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_USER_NAME' ).
    lo_parameter->set_edm_name( 'JobUserName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_USER_NAME' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_TEXT' ).
    lo_parameter->set_edm_name( 'JobText' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_TEXT_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_TEMPLATE_NAME' ).
    lo_parameter->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_TEMPLATE_NAME' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_PARAMETER_VALUES' ).
    lo_parameter->set_edm_name( 'JobParameterValues' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_PARAMETER_VALUES' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'TEST_MODE_IND' ).
    lo_parameter->set_edm_name( 'TestModeInd' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'TEST_MODE_IND' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_USER' ).
    lo_parameter->set_edm_name( 'JobUser' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_USER' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_PARAMETER_VALUES_SIMPL' ).
    lo_parameter->set_edm_name( 'JobParameterValuesSimple' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_PARAMETER_VALUES_SIMPL' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'JOB_SCHEDULE_STATUS' ).

  ENDMETHOD.


  METHOD def_job_schedule_check.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'JOB_SCHEDULE_CHECK' ).
    lo_function->set_edm_name( 'JobScheduleCheck' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_13( ) ).

    lo_function_import = lo_function->create_function_import( 'JOB_SCHEDULE_CHECK' ).
    lo_function_import->set_edm_name( 'JobScheduleCheck' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'POST' ).


    lo_parameter = lo_function->create_parameter( 'JOB_USER' ).
    lo_parameter->set_edm_name( 'JobUser' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_USER_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_PARAMETER_VALUES' ).
    lo_parameter->set_edm_name( 'JobParameterValues' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_PARAMETER_VALUES_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_TEMPLATE_NAME' ).
    lo_parameter->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_TEMPLATE_NAME_2' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_PARAMETER_VALUES_SIMPL' ).
    lo_parameter->set_edm_name( 'JobParameterValuesSimple' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_PARAMETER_VALUES_SIM_2' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'JOB_SCHEDULE_CHECK_3' ).

  ENDMETHOD.


  METHOD def_job_schedule_check_3.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_SCHEDULE_CHECK_3'
                                    is_structure              = VALUE tys_job_schedule_check_3( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobScheduleCheck' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_SCHEDULE_CHECK_COLLECT' ).
    lo_entity_set->set_edm_name( 'JobScheduleCheckCollection' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_PARAMETER_VALUES' ).
    lo_primitive_property->set_edm_name( 'JobParameterValues' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SUCCESSFUL_IND' ).
    lo_primitive_property->set_edm_name( 'SuccessfulInd' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CHANGED_IND' ).
    lo_primitive_property->set_edm_name( 'ChangedInd' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'DYNAMIC_PROPERTIES' ).
    lo_primitive_property->set_edm_name( 'DynamicProperties' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'ERR_MESSAGES' ).
    lo_primitive_property->set_edm_name( 'ErrMessages' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.

  ENDMETHOD.


  METHOD def_job_schedule_status.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_SCHEDULE_STATUS'
                                    is_structure              = VALUE tys_job_schedule_status( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobScheduleStatus' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_SCHEDULE_STATUS_COLLEC' ).
    lo_entity_set->set_edm_name( 'JobScheduleStatusCollection' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_NAME' ).
    lo_primitive_property->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 32 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_RUN_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_STATUS' ).
    lo_primitive_property->set_edm_name( 'JobStatus' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'RETURN_CODE' ).
    lo_primitive_property->set_edm_name( 'ReturnCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int16' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

  ENDMETHOD.


  METHOD def_job_status_get.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'JOB_STATUS_GET' ).
    lo_function->set_edm_name( 'JobStatusGet' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_2( ) ).

    lo_function_import = lo_function->create_function_import( 'JOB_STATUS_GET' ).
    lo_function_import->set_edm_name( 'JobStatusGet' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'GET' ).


    lo_parameter = lo_function->create_parameter( 'JOB_NAME' ).
    lo_parameter->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_NAME_5' ).
    lo_parameter->set_is_nullable( ).

    lo_parameter = lo_function->create_parameter( 'JOB_RUN_COUNT' ).
    lo_parameter->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_RUN_COUNT_4' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'JOB_SCHEDULE_STATUS' ).

  ENDMETHOD.


  METHOD def_job_status_info.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_STATUS_INFO'
                                    is_structure              = VALUE tys_job_status_info( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobStatusInfo' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_STATUS_INFO_SET' ).
    lo_entity_set->set_edm_name( 'JobStatusInfoSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_STATUS' ).
    lo_primitive_property->set_edm_name( 'JobStatus' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_STATUS_TEXT' ).
    lo_primitive_property->set_edm_name( 'JobStatusText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 60 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

  ENDMETHOD.


  METHOD def_job_step.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_STEP'
                                    is_structure              = VALUE tys_job_step( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobStep' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_STEP_SET' ).
    lo_entity_set->set_edm_name( 'JobStepSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_NAME' ).
    lo_primitive_property->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 32 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_RUN_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_NUMBER' ).
    lo_primitive_property->set_edm_name( 'StepNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_CATALOG_ENTRY_NAME' ).
    lo_primitive_property->set_edm_name( 'JobCatalogEntryName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_CATALOG_ENTRY_TEXT' ).
    lo_primitive_property->set_edm_name( 'JobCatalogEntryText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_START_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'StepStartDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_STATUS' ).
    lo_primitive_property->set_edm_name( 'StepStatus' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_APP_RC' ).
    lo_primitive_property->set_edm_name( 'StepAppRC' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_HAS_RESULTS' ).
    lo_primitive_property->set_edm_name( 'StepHasResults' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'NR_OF_LOGS' ).
    lo_primitive_property->set_edm_name( 'NrOfLogs' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_STEP_LOG_INFO_SET' ).
    lo_navigation_property->set_edm_name( 'JobStepLogInfoSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_STEP_LOG_INFO' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.


  METHOD def_job_step_log_info.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_STEP_LOG_INFO'
                                    is_structure              = VALUE tys_job_step_log_info( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobStepLogInfo' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_STEP_LOG_INFO_SET' ).
    lo_entity_set->set_edm_name( 'JobStepLogInfoSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_NAME' ).
    lo_primitive_property->set_edm_name( 'JobName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 32 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_RUN_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobRunCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 8 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STEP_NUMBER' ).
    lo_primitive_property->set_edm_name( 'StepNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LOG_HANDLE' ).
    lo_primitive_property->set_edm_name( 'LogHandle' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 22 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LOG_NUMBER' ).
    lo_primitive_property->set_edm_name( 'LogNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_CNT_ALL' ).
    lo_primitive_property->set_edm_name( 'MsgCntAll' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_CNT_A' ).
    lo_primitive_property->set_edm_name( 'MsgCntA' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_CNT_E' ).
    lo_primitive_property->set_edm_name( 'MsgCntE' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_CNT_W' ).
    lo_primitive_property->set_edm_name( 'MsgCntW' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_CNT_I' ).
    lo_primitive_property->set_edm_name( 'MsgCntI' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'MSG_CNT_S' ).
    lo_primitive_property->set_edm_name( 'MsgCntS' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREA_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'CreaDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 20 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREA_USER' ).
    lo_primitive_property->set_edm_name( 'CreaUser' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREA_USER_LONG' ).
    lo_primitive_property->set_edm_name( 'CreaUserLong' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SEVERITY' ).
    lo_primitive_property->set_edm_name( 'Severity' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SEVERITY_TEXT' ).
    lo_primitive_property->set_edm_name( 'SeverityText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_LOG_MESSAGE_SET' ).
    lo_navigation_property->set_edm_name( 'JobLogMessageSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_LOG_MESSAGE' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.


  METHOD def_job_template.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_TEMPLATE'
                                    is_structure              = VALUE tys_job_template( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobTemplate' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_TEMPLATE_SET' ).
    lo_entity_set->set_edm_name( 'JobTemplateSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_REPORT_NAME' ).
    lo_primitive_property->set_edm_name( 'JobReportName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_VERSION' ).
    lo_primitive_property->set_edm_name( 'JobTemplateVersion' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_USER_NAME' ).
    lo_primitive_property->set_edm_name( 'JobUserName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_CATALOG_ENTRY_NAME' ).
    lo_primitive_property->set_edm_name( 'JobCatalogEntryName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SUPPORTS_TEST_MODE' ).
    lo_primitive_property->set_edm_name( 'SupportsTestMode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Boolean' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_TEXT' ).
    lo_primitive_property->set_edm_name( 'JobTemplateText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREATION_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'CreationDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 7 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREATION_USER_NAME' ).
    lo_primitive_property->set_edm_name( 'CreationUserName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LAST_CHANGE_DATE_TIME' ).
    lo_primitive_property->set_edm_name( 'LastChangeDateTime' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'DateTimeOffset' ) ##NO_TEXT.
    lo_primitive_property->set_precision( 7 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).
    lo_primitive_property->set_edm_type_v2( 'DateTime' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LAST_CHANGE_USER_NAME' ).
    lo_primitive_property->set_edm_name( 'LastChangeUserName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 12 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_PERIODIC_GRANULARITY' ).
    lo_primitive_property->set_edm_name( 'JobPeriodicGranularity' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_PERIODIC_VALUE' ).
    lo_primitive_property->set_edm_name( 'JobPeriodicValue' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_LAYER_C' ).
    lo_primitive_property->set_edm_name( 'JobTemplateLayerC' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_HIDDEN_IND' ).
    lo_primitive_property->set_edm_name( 'JobTemplateHiddenInd' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_CATALOG_ENTRY_TYPE_C' ).
    lo_primitive_property->set_edm_name( 'JobCatalogEntryTypeC' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_STEP_COUNT' ).
    lo_primitive_property->set_edm_name( 'JobTemplateStepCount' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_SEQUENCE' ).
    lo_primitive_property->set_edm_name( 'JobTemplateSequence' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_VALUES' ).
    lo_primitive_property->set_edm_name( 'JobTemplateValues' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TEXT' ).
    lo_primitive_property->set_edm_name( 'Text' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'TEXT_EN' ).
    lo_primitive_property->set_edm_name( 'TextEn' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_CATALOG_ENTRY_TEXT' ).
    lo_primitive_property->set_edm_name( 'JobCatalogEntryText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CREATION_FORMATTED_NAME' ).
    lo_primitive_property->set_edm_name( 'CreationFormattedName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 255 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LAST_CHANGE_FORMATTED_NAME' ).
    lo_primitive_property->set_edm_name( 'LastChangeFormattedName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 255 ) ##NUMBER_OK.
    lo_primitive_property->set_is_nullable( ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_TEMPLATE_PARAMETER_SET' ).
    lo_navigation_property->set_edm_name( 'JobTemplateParameterSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_TEMPLATE_PARAMETER' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_TEMPLATE_PARAM_GROUP_S' ).
    lo_navigation_property->set_edm_name( 'JobTemplateParamGroupSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_TEMPLATE_PARAM_GROUP' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_TEMPLATE_PARAM_SECTION' ).
    lo_navigation_property->set_edm_name( 'JobTemplateParamSectionSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_TEMPLATE_PARAM_SECTI_2' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_TEMPLATE_SEQUENCE_SET' ).
    lo_navigation_property->set_edm_name( 'JobTemplateSequenceSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_TEMPLATE_SEQUENCE' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.


  METHOD def_job_template_parameter.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_TEMPLATE_PARAMETER'
                                    is_structure              = VALUE tys_job_template_parameter( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobTemplateParameter' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_TEMPLATE_PARAMETER_SET' ).
    lo_entity_set->set_edm_name( 'JobTemplateParameterSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'BASIC_JOB_CATALOG_ENTRY_NA' ).
    lo_primitive_property->set_edm_name( 'BasicJobCatalogEntryName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMP_PARAM_HAS_VH_IND' ).
    lo_primitive_property->set_edm_name( 'JobTempParamHasVhInd' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMP_PARAM_READ_ONLY_I' ).
    lo_primitive_property->set_edm_name( 'JobTempParamReadOnlyInd' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_PARAM_GROUP_N' ).
    lo_primitive_property->set_edm_name( 'JobTemplateParamGroupName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_SEQUENCE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobSequenceName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_VERSION' ).
    lo_primitive_property->set_edm_name( 'JobTemplateVersion' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_PARAMETER_NAM' ).
    lo_primitive_property->set_edm_name( 'JobTemplateParameterName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 38 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMP_PARAM_HIDDEN_IND' ).
    lo_primitive_property->set_edm_name( 'JobTempParamHiddenInd' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMP_PARAM_MANDATORY_I' ).
    lo_primitive_property->set_edm_name( 'JobTempParamMandatoryInd' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_TEMPLATE_PARAMETER_VAL' ).
    lo_navigation_property->set_edm_name( 'JobTemplateParameterValueDataSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_TEMPLATE_PARAMETER_V_2' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.


  METHOD def_job_template_parameter_v_2.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_TEMPLATE_PARAMETER_V_2'
                                    is_structure              = VALUE tys_job_template_parameter_v_2( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobTemplateParameterValueData' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_TEMPLATE_PARAMETER_VAL' ).
    lo_entity_set->set_edm_name( 'JobTemplateParameterValueDataSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_VERSION' ).
    lo_primitive_property->set_edm_name( 'JobTemplateVersion' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_PARAMETER_NAM' ).
    lo_primitive_property->set_edm_name( 'JobTemplateParameterName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 38 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'UUID' ).
    lo_primitive_property->set_edm_name( 'Uuid' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 32 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'SIGN' ).
    lo_primitive_property->set_edm_name( 'Sign' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'OPT' ).
    lo_primitive_property->set_edm_name( 'Opt' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 2 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'LOW' ).
    lo_primitive_property->set_edm_name( 'Low' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 255 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'HIGH' ).
    lo_primitive_property->set_edm_name( 'High' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 255 ) ##NUMBER_OK.

  ENDMETHOD.


  METHOD def_job_template_param_group.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_TEMPLATE_PARAM_GROUP'
                                    is_structure              = VALUE tys_job_template_param_group( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobTemplateParamGroup' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_TEMPLATE_PARAM_GROUP_S' ).
    lo_entity_set->set_edm_name( 'JobTemplateParamGroupSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_SEQUENCE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobSequenceName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_VERSION' ).
    lo_primitive_property->set_edm_name( 'JobTemplateVersion' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_PARAM_GROUP_N' ).
    lo_primitive_property->set_edm_name( 'JobTemplateParamGroupName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_PARAM_GROUP_T' ).
    lo_primitive_property->set_edm_name( 'JobTemplateParamGroupText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_PARAMETER_SECTION_NAME' ).
    lo_primitive_property->set_edm_name( 'JobParameterSectionName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BASIC_JOB_CATALOG_ENTRY_NA' ).
    lo_primitive_property->set_edm_name( 'BasicJobCatalogEntryName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BASIC_JOB_TEMPLATE_GROUP_N' ).
    lo_primitive_property->set_edm_name( 'BasicJobTemplateGroupName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_TEMPLATE_PARAMETER_SET' ).
    lo_navigation_property->set_edm_name( 'JobTemplateParameterSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_TEMPLATE_PARAMETER' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.


  METHOD def_job_template_param_secti_2.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_TEMPLATE_PARAM_SECTI_2'
                                    is_structure              = VALUE tys_job_template_param_secti_2( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobTemplateParamSection' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_TEMPLATE_PARAM_SECTION' ).
    lo_entity_set->set_edm_name( 'JobTemplateParamSectionSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_VERSION' ).
    lo_primitive_property->set_edm_name( 'JobTemplateVersion' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_SEQUENCE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobSequenceName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_PARAMETER_SECTION_NAME' ).
    lo_primitive_property->set_edm_name( 'JobParameterSectionName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_PARAMETER_SECTION_POSI' ).
    lo_primitive_property->set_edm_name( 'JobParameterSectionPosition' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_PARAMETER_SECTION_TEXT' ).
    lo_primitive_property->set_edm_name( 'JobParameterSectionText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BASIC_JOB_CATALOG_ENTRY_NA' ).
    lo_primitive_property->set_edm_name( 'BasicJobCatalogEntryName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_TEMPLATE_PARAM_GROUP_S' ).
    lo_navigation_property->set_edm_name( 'JobTemplateParamGroupSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_TEMPLATE_PARAM_GROUP' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.


  METHOD def_job_template_param_value_2.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_TEMPLATE_PARAM_VALUE_2'
                                    is_structure              = VALUE tys_job_template_param_value_2( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobTemplateParamValueData' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_TEMPLATE_PARAM_VALUE_D' ).
    lo_entity_set->set_edm_name( 'JobTemplateParamValueDataSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'TEMPLATE_DATA' ).
    lo_primitive_property->set_edm_name( 'TemplateData' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_is_key( ).

  ENDMETHOD.


  METHOD def_job_template_read.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'JOB_TEMPLATE_READ' ).
    lo_function->set_edm_name( 'JobTemplateRead' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_3( ) ).

    lo_function_import = lo_function->create_function_import( 'JOB_TEMPLATE_READ' ).
    lo_function_import->set_edm_name( 'JobTemplateRead' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'GET' ).


    lo_parameter = lo_function->create_parameter( 'JOB_TEMPLATE_NAME' ).
    lo_parameter->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_TEMPLATE_NAME_4' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'JOB_TEMPLATE_PARAM_VALUE_2' ).

  ENDMETHOD.


  METHOD def_job_template_sequence.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'JOB_TEMPLATE_SEQUENCE'
                                    is_structure              = VALUE tys_job_template_sequence( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'JobTemplateSequence' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'JOB_TEMPLATE_SEQUENCE_SET' ).
    lo_entity_set->set_edm_name( 'JobTemplateSequenceSet' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_TEMPLATE_VERSION' ).
    lo_primitive_property->set_edm_name( 'JobTemplateVersion' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 1 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JCE_TEXT' ).
    lo_primitive_property->set_edm_name( 'JceText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_SEQUENCE_NAME' ).
    lo_primitive_property->set_edm_name( 'JobSequenceName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ) ##NUMBER_OK.
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_SEQUENCE_POSITION' ).
    lo_primitive_property->set_edm_name( 'JobSequencePosition' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'Int32' ) ##NO_TEXT.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'JOB_SEQUENCE_TEXT' ).
    lo_primitive_property->set_edm_name( 'JobSequenceText' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 120 ) ##NUMBER_OK.

    lo_primitive_property = lo_entity_type->get_primitive_property( 'BASIC_JOB_CATALOG_ENTRY_NA' ).
    lo_primitive_property->set_edm_name( 'BasicJobCatalogEntryName' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 40 ) ##NUMBER_OK.

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_TEMPLATE_PARAMETER_SET' ).
    lo_navigation_property->set_edm_name( 'JobTemplateParameterSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_TEMPLATE_PARAMETER' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

    lo_navigation_property = lo_entity_type->create_navigation_property( 'JOB_TEMPLATE_PARAM_SECTION' ).
    lo_navigation_property->set_edm_name( 'JobTemplateParamSectionSet' ) ##NO_TEXT.
    lo_navigation_property->set_target_entity_type_name( 'JOB_TEMPLATE_PARAM_SECTI_2' ).
    lo_navigation_property->set_target_multiplicity( /iwbep/if_v4_pm_types=>gcs_nav_multiplicity-to_many_optional ).

  ENDMETHOD.


  METHOD def_template_values_get.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'TEMPLATE_VALUES_GET' ).
    lo_function->set_edm_name( 'TemplateValuesGet' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_4( ) ).

    lo_function_import = lo_function->create_function_import( 'TEMPLATE_VALUES_GET' ).
    lo_function_import->set_edm_name( 'TemplateValuesGet' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'GET' ).


    lo_parameter = lo_function->create_parameter( 'JOB_TEMPLATE_NAME' ).
    lo_parameter->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_TEMPLATE_NAME_3' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'JOB_PARAM_VALUES' ).

  ENDMETHOD.


  METHOD def_template_values_struct_get.

    DATA:
      lo_function        TYPE REF TO /iwbep/if_v4_pm_function,
      lo_function_import TYPE REF TO /iwbep/if_v4_pm_func_imp,
      lo_parameter       TYPE REF TO /iwbep/if_v4_pm_func_param,
      lo_return          TYPE REF TO /iwbep/if_v4_pm_func_return.


    lo_function = mo_model->create_function( 'TEMPLATE_VALUES_STRUCT_GET' ).
    lo_function->set_edm_name( 'TemplateValuesStructGet' ) ##NO_TEXT.

    " Name of the runtime structure that represents the parameters of this operation
    lo_function->/iwbep/if_v4_pm_fu_advanced~set_parameter_structure_info( VALUE tys_parameters_5( ) ).

    lo_function_import = lo_function->create_function_import( 'TEMPLATE_VALUES_STRUCT_GET' ).
    lo_function_import->set_edm_name( 'TemplateValuesStructGet' ) ##NO_TEXT.
    lo_function_import->/iwbep/if_v4_pm_func_imp_v2~set_http_method( 'GET' ).


    lo_parameter = lo_function->create_parameter( 'JOB_TEMPLATE_NAME' ).
    lo_parameter->set_edm_name( 'JobTemplateName' ) ##NO_TEXT.
    lo_parameter->set_primitive_type( 'JOB_TEMPLATE_NAME_5' ).
    lo_parameter->set_is_nullable( ).

    lo_return = lo_function->create_return( ).
    lo_return->set_entity_type( 'JOB_PARAM_VALUES_STRUCT' ).
    lo_return->set_is_collection( ).

  ENDMETHOD.
ENDCLASS.
