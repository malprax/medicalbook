MEDICALBOOK.namespace 'Common', (() ->
  return {
    init: ->
      NProgress.configure({
        showSpinner: false,
      })

    # change other fields when keyup
    changeOtherWhenKeyup: (klass) ->
      $(klass).keyup ->
        target = $($(this).data('target'))
        target.val($(this).val())
        target.prop('checked', true)

    autoFillSignUp: ->
      $('#therapist_first_name').val('adhiguna')
      $('#therapist_last_name').val('sabril')
      $('#therapist_company').val('sabril')
      $('#therapist_address_attributes_phone').val('085299277500')
      $('#therapist_address_attributes_address_1').val('Private Village B3 no 77')
      $('#therapist_address_attributes_country').val('ID')
      $('#therapist_address_attributes_city').val('Bandung')
      $('#therapist_address_attributes_zip').val('40288')
      $('#therapist_address_attributes_state').val('West Java')

    autoFillSignUpPatient: ->
      $('#patient_first_name').val('ruby')
      $('#patient_last_name').val('syaifani')
      $('#patient_company').val('sabril')
      $('#patient_addresses_attributes_0_phone').val('085299277500')
      $('#patient_addresses_attributes_0_address_1').val('Private Village B3 no 77')
      $('#patient_addresses_attributes_0_country').val('ID')
      $('#patient_addresses_attributes_0_city').val('Bandung')
      $('#patient_addresses_attributes_0_zip').val('40288')
      $('#patient_addresses_attributes_0_state').val('West Java')
  }
)(jQuery)

# load all common in here
MEDICALBOOK.Common.init()
