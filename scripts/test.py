import pathlib
import syside

EXAMPLE_DIR = pathlib.Path(__file__).parent.parent / "model"
paths = syside.collect_files_recursively(EXAMPLE_DIR)

def walk_ownership_tree(element: syside.Element, level: int = 0) -> None:
    """
    Prints out all elements in a model in a tree-like format, where child
    elements appear indented under their parent elements. For example:

    Parent
      Child1
      Child2
        Grandchild

    Args:
        element: The model element to start printing from
        level: How many levels to indent (increases for nested elements)
    """
    if element.name is not None:
        print("  " * level, element.name)
    else:
        print("  " * level, "anonymous element")
    # Recursively call walk_ownership_tree() for each owned element
    # (child element).
    element.owned_elements.for_each(
        lambda owned_element: walk_ownership_tree(owned_element, level + 1)
    )


def show_part_decomposition(
    element: syside.Element, part_level: int = 0
) -> None:
    """
    Prints out a hierarchical view of parts in a model, with indentation
    showing parent-child relationships. The function calls itself repeatedly
    to handle nested parts at deeper levels.

    For example, if a car has an engine and wheels, it would print:
    Car
      Engine
      Wheels

    Args:
        element: The model element to start printing from
        part_level: How many levels of indentation to use (increases for
        nested parts)
    """
    if element.try_cast(syside.PartUsage):  # Check if element is a part usage
        print("  " * part_level, element.name)
        new_part_level = part_level + 1
    else:
        new_part_level = part_level
    # Recursively call show_part_decomposition() for each owned element
    # (child element).
    element.owned_elements.for_each(
        lambda owned_element: show_part_decomposition(
            owned_element, new_part_level
        )
    )


def show_parts_of_type(model: syside.Model, part_type: str) -> None:
    for part in model.nodes(syside.PartUsage):
        for element in part.heritage.elements:
            if element.try_cast(syside.PartDefinition):
                if element.declared_name == part_type:
                    print("- ", part.name)


def main() -> None:
    (model, diagnostics) = syside.load_model(paths)

    # Only errors cause an exception. Syside may also report warnings and
    # informational messages, but not for this example.
    assert not diagnostics.contains_errors(warnings_as_errors=True)

    print("\nShow part decomposition.")
    for doc in model.user_docs:
        with doc.lock() as locked:
            show_part_decomposition(locked.root_node)

if __name__ == "__main__":
    main()