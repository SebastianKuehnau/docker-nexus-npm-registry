package org.vaadin.sebastian;

import com.vaadin.flow.component.html.Label;
import com.vaadin.flow.component.html.NativeButton;
import com.vaadin.flow.component.listbox.ListBox;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.router.Route;
import com.vaadin.flow.server.PWA;


/**
 * The main view contains a button and a click listener.
 */
@Route("")
@PWA(name = "Project Base for Vaadin", shortName = "Project Base")
public class MainView extends VerticalLayout {

    public MainView() {
        Label message = new Label();

        ListBox<String> listBox = new ListBox<>();
        listBox.setItems("Bread", "Butter", "Milk");

        listBox.addValueChangeListener(event -> message.setText(String.format(
                "Selection changed from %s to %s, selection is from client: %s",
                event.getOldValue(), event.getValue(), event.isFromClient())));

        NativeButton button = new NativeButton("Select Milk",
                event -> listBox.setValue("Milk"));

        add(listBox, message, button);
    }
}
