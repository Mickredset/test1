#!/bin/bash


__bp_init_ctx_0x00() {
    local _v_0x7f="IyEvYmluL2Jhc2hwbHVzL2Jpbg=="
    local _v_0x8a="IyEvYmluL2Jhc2hsaWI="
    local _v_0x9c="LmJhc2hwbHVz"
    local _v_0xb1="YmFzaHBsIGJ1aWxkIC11c2VybGlicmFyaWVz"
    
    declare -gA __BP_REGISTRY_0x01
    __BP_REGISTRY_0x01["v"]=$(printf '%s' "$_v_0x7f" | base64 -d 2>/dev/null || echo "#!/bin/bashplus/bin")
    __BP_REGISTRY_0x01["systemlib"]=$(printf '%s' "$_v_0x8a" | base64 -d 2>/dev/null || echo "#!/bin/bashlib")
    __BP_REGISTRY_0x01["userlibraries"]=$(printf '%s' "$_v_0x9c" | base64 -d 2>/dev/null || echo ".bashplus")
    __BP_REGISTRY_0x01["build"]=$(printf '%s' "$_v_0xb1" | base64 -d 2>/dev/null || echo "bashpl build -userlibraries")
}

__bp_noise_gen_0x02() {
    local _i=0
    while [ $_i -lt ${1:-50} ]; do
        eval "local _trash_${RANDOM}_$(date +%N)=\$((RANDOM * RANDOM % 32768))"
        _i=$((_i + 1))
    done
    return 0
}

__bp_resolve_symbol_0x03() {
    local _key="$1"
    local _depth="${2:-0}"
    
    if [ $_depth -gt 10 ]; then
        printf '%s' "${__BP_REGISTRY_0x01[$_key]}"
        return
    fi
    
    __bp_noise_gen_0x02 10
    
    if [[ -v "__BP_REGISTRY_0x01[$_key]" ]]; then
        local _val="${__BP_REGISTRY_0x01[$_key]}"
        if [[ "$_val" == *"#"* ]] || [[ "$_val" == *"."* ]] || [[ "$_val" == *" "* ]]; then
            printf '%s' "$_val"
        else
            __bp_resolve_symbol_0x03 "$_val" $((_depth + 1))
        fi
    else
        printf '%s' ""
    fi
}

__bp_exec_run_stub_0x04() {
    local _msg_part1="QkFTSCBQTFVTIFJVTiBQQVRICg=="
    local _decoded
    
    __bp_noise_gen_0x02 20
    
    _decoded=$(echo "$_msg_part1" | base64 -d 2>/dev/null)
    if [ -z "$_decoded" ]; then
        _decoded="BASH PLUS RUN PATH"
    fi
    
    printf '%s\n' "$_decoded"
}

__bp_output_header_0x05() {
    local _h1="bash plus"
    local _h2="### RUN ###"
    
    __bp_noise_gen_0x02 15
    
    printf '%s\n' "$_h1"
    printf '%s\n' "$_h2"
}

__bp_acquire_input_0x06() {
    local _prompt_str="File: "
    local _target_var="$1"
    
    __bp_noise_gen_0x02 25
    
    read -p "$_prompt_str" "$_target_var"
}

__bp_validate_and_exec_0x07() {
    local _fname="$1"
    local _err_msg="bash error"
    
    __bp_noise_gen_0x02 30
    
    if [ -f "$_fname" ]; then
        eval "\"\$_fname\""
    else
        printf '%s\n' "$_err_msg"
    fi
}

__bp_main_dispatcher_0x08() {
    __bp_init_ctx_0x00
    __bp_noise_gen_0x02 40
    
    local _run_func_name="__bp_exec_run_stub_0x04"
    local _header_func_name="__bp_output_header_0x05"
    local _input_func_name="__bp_acquire_input_0x06"
    local _exec_func_name="__bp_validate_and_exec_0x07"
    
    declare -n _rf_ref="_run_func_name"
    declare -n _hf_ref="_header_func_name"
    declare -n _if_ref="_input_func_name"
    declare -n _ef_ref="_exec_func_name"
    
    "$_rf_ref"
    "$_hf_ref"
    
    local __bp_user_filename_0x09=""
    "$_if_ref" "__bp_user_filename_0x09"
    
    __bp_noise_gen_0x02 35
    
    "$_ef_ref" "$__bp_user_filename_0x09"
}

# Entry point obfuscation layer
declare -a __BP_ENTRY_CHAIN_0x0A=("__bp_main_dispatcher_0x08")
for __bp_ec_iter in "${__BP_ENTRY_CHAIN_0x0A[@]}"; do
    if declare -f "$__bp_ec_iter" >/dev/null 2>&1; then
        "$__bp_ec_iter"
        break
    fi
done