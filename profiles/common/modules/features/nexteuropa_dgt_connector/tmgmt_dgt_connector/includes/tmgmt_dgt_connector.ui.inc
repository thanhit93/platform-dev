<?php
/**
 * @file
 * Extends the Workbench Moderation UI source controller.
 */

/**
 * Class TMGMTWorkbenchCardSourceUIController.
 */
class TMGMTWorkbenchCardSourceUIController extends TMGMTWorkbenchSourceUIController {

  /**
   * {@inheritdoc}
   */
  public function getEntitiesTranslationData($type, $property_conditions = array()) {
    $entities_data = parent::getEntitiesTranslationData($type, $property_conditions);
    // If one workbench moderate has one active job, it cannot be display in
    // the UI.
    foreach ($entities_data as $key => $entity_data) {
      $current_job_items = $entity_data['current_job_items'];
      foreach ($current_job_items as $current_job_item) {
        if (!empty($current_job_item)) {
          unset($entities_data[$key]);
          break;
        }
      }
    }

    return $entities_data;
  }

}
